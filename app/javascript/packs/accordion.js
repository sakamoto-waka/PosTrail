$(function() {
  $('.accordion-parent').on('click', function() {
    $(this).next().slideToggle('fast');
  });
});