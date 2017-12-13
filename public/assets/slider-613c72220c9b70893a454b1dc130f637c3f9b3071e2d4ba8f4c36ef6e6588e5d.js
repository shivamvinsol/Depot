function Slider(options) {
  this.$slides = options.slides;
  this.$currentSlide = this.$slides.first();
}

Slider.prototype.initialize = function() {
  var _this = this;
  this.$slides.hide();

  this.displaySlide();

  setInterval(function(){
    _this.displaySlide();
  }, 3000);
};

Slider.prototype.displaySlide = function() {
  this.$currentSlide.fadeIn(100).delay(2800).fadeOut(100);
  this.getNextSlide();
};

Slider.prototype.getNextSlide = function() {
  if (this.$currentSlide.is(this.$slides.last())) {
  	this.$currentSlide = this.$slides.first();
  } else {
  	this.$currentSlide = this.$currentSlide.next();
  }
};

$(function() {
  var options = {
  	slides: $("[data-name='image-slide']")
  },
  slider = new Slider(options);

  slider.initialize();
})
;
