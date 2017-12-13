function OrderReports(options) {
  this.$form = options.$form;
  this.$fromDate = options.$fromDate;
  this.$toDate = options.$toDate;
  this.$displayArea = options.$displayArea;
  this.$submitButton = options.$submitButton;
}

OrderReports.prototype.initialize = function() {
  this.bindEvents();
};

OrderReports.prototype.validateData = function() {
  if (this.$fromDate.val() === "" || this.$toDate.val() === "" || (this.$fromDate.val() > this.$toDate.val())) {
    var $result = $('<h1>').html("Enter valid dates").addClass('alert');
    this.$displayArea.empty().append($result);
    return false;
  }
  return true;
};

OrderReports.prototype.bindEvents = function() {
  this.$form.on("submit", this.getOrders());
};

OrderReports.prototype.getOrders = function() {
  var _this = this;

  return function() {
    event.preventDefault();
    var isValidData = _this.validateData();

    if (isValidData) {
      $.ajax({
        url: 'api/reports',
        type: 'POST',
        dataType: 'JSON',
        data: { from_date: _this.$fromDate.val(), to_date: _this.$toDate.val() },

        success: function(data) {
          _this.orders = data.orders;
          _this.displayOrders();
        },

        error: function(xhr, status) {
          alert("Please try some time later");
        }
      });
    }
  };
};

OrderReports.prototype.displayOrders = function() {

  this.$displayArea.empty();

  if (this.orders.length === 0) {
    var $result = $('<h1>').html("No Orders!").addClass('alert');
    this.$displayArea.append($result);
  } else {
    var documentFragment = document.createDocumentFragment(),
        $list = $('<table>', { border: '1' }),
        $order, $name, $address, $email, $payType;

      $.each(this.orders, function() {
        $order = $('<tr>');
        $name = $('<td>').text(this.name);
        $address = $('<td>').text(this.address);
        $email = $('<td>').text(this.email);
        $payType = $('<td>').text(this.pay_type);
        $order.append($name, $address, $email, $payType);
        $list.append($order);
      });
      documentFragment.append($list[0]);
  }

  this.$displayArea.append(documentFragment);
};

$(function() {
  var options = {
    $form: $('[data-name="order-form"]'),
    $fromDate: $('[data-name="order_from_date"]'),
    $toDate: $('[data-name="order_to_date"]'),
    $displayArea: $('[data-name="show-orders"]'),
    $submitButton: $('[data-name="submit-button"]')
  },
    orderReports = new OrderReports(options);
  orderReports.initialize();
});
