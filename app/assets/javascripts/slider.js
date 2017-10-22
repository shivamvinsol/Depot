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
  }, 2000);
};

Slider.prototype.displaySlide = function() {
  this.$currentSlide.fadeIn(1000).fadeOut(1000);
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