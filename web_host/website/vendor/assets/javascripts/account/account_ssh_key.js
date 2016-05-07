$(document).on('ready page:load', function() {
  $('button#add_ssh_key').on('click', function() {
    $('form#new_account_ssh_key').show();
  })

  if ($('form#new_account_ssh_key').data('has-errors')) {
    $('form#new_account_ssh_key').show();
  }
});