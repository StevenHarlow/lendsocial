//= require jquery
//= require jquery_ujs
//= require_tree .

$('[placeholder]').focus(function() {
  var input = $(this);
  if (input.val() == input.attr('placeholder')) {
    input.val('');
    input.removeClass('placeholder');
  }
}).blur(function() {
  var input = $(this);
  if (input.val() == '' || input.val() == input.attr('placeholder')) {
    input.addClass('placeholder');
    input.val(input.attr('placeholder'));
  }
}).blur();

$('[placeholder]').parents('form').submit(function() {
  $(this).find('[placeholder]').each(function() {
    var input = $(this);
    if (input.val() == input.attr('placeholder')) {
      input.val('');
    }
  });
});

$.validator.prototype.showLabel = function(element, message) {
  var el = this.errorsFor(element);
  if (el.length) {
    el.removeClass(this.settings.validClass).addClass(this.settings.errorClass);
    el.html(message);
  } else {
    el  = $("<" + this.settings.errorElement + "/>").html(message || "");
    if (this.settings.wrapper) {
      el = el.hide().show().wrap("<" + this.settings.wrapper + "/>").parent();
    }
    if (!this.labelContainer.append(el).length)
      this.settings.errorPlacement ? this.settings.errorPlacement(el, $(element)) : el.insertAfter(element);
  }
  if (!message && this.settings.success) {
    el.text('');
    typeof this.settings.success == "string" ? el.addClass(this.settings.success) : this.settings.success(el);
  }
  this.toShow = this.toShow.add(el);
};
