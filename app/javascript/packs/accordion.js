$(function() {
  $(document).on('click', '.accordion-parent', function() {
    $(this).next().slideToggle('fast');
  });
});