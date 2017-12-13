function ProductRater(options) {
  this.$rater = options.$rater;
  this.productSelector = options.productSelector;
  this.displayAreaSelector = options.displayAreaSelector;
  this.rateProductPath = options.$rateProductPath.data('path');
  this.productRatingSelector = options.productRatingSelector;
}

ProductRater.prototype.intialize = function() {
  this.bindEvents();
};

ProductRater.prototype.bindEvents = function() {
  this.$rater.on('change', this.rateProduct());
};

ProductRater.prototype.rateProduct = function() {
  var _this = this;

  return function() {
    var $this = $(this);
    $.ajax({
      url: _this.rateProductPath,
      type: 'POST',
      dataType: 'JSON',

      // safe to name product_id?
      data: { product_id: $this.data('id'), rating: $this.val() },

      success: function(data) {
        _this.$displayArea = $this.closest(_this.productSelector).find(_this.displayAreaSelector);
        _this.newRating = data.new_rating;
        _this.displayRating();
      },

      error: function(xhr, status) {
        alert("Please try some time later")
      }
    });
  };
};

ProductRater.prototype.displayRating = function() {
  alert("Thank you for rating the product");
  debugger
  this.$displayArea.find(this.productRatingSelector).html(this.newRating);
  // this.$displayArea.empty().append("Product Rating: " + this.newRating + "/5");
};

$(function() {
  var options = {
    $rater: $('[data-name="rate-product"]'),
    $rateProductPath: $('[data-name="api_path"]'),
    productSelector: '[data-name="product"]',
    displayAreaSelector: '[data-name="display-rating"]',
    productRatingSelector: '[data-name="product-rating"]'
  }
  rater = new ProductRater(options);
  rater.intialize();
})
;
