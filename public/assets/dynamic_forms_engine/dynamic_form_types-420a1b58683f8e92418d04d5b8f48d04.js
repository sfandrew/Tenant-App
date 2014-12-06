(function() {
  var init_autocomplete, ready;

  init_autocomplete = function($element) {
    var auto_complete_source;
    console.log($element);
    auto_complete_source = $('.name-search').data('autocomplete-source');
    return $element.autocomplete({
      change: function(event, ui) {
        var company, contacts, email, name_search, phone, type;
        name_search = $(this).val();
        contacts = $element.data('contacts');
        phone = contacts[name_search][1];
        email = contacts[name_search][2];
        if (contacts[name_search][3] != null) {
          company = contacts[name_search][3];
        } else {
          company = "No company";
        }
        if (contacts[name_search][0] === "Property Manager" || contacts[name_search][0] === "Landlord" || contacts[name_search][0] === "Resident Manager" || contacts[name_search][0] === "Roommate") {
          type = contacts[name_search][0];
        } else {
          type = "Other";
        }
        $(this).closest("fieldset").find(".phone-field").val(phone);
        $(this).closest("fieldset").find(".email-field").val(email);
        $(this).closest("fieldset").find(".company-field").val(company);
        return $(this).closest("fieldset").find(".type-field").val(type);
      },
      source: $('.name-search').data('autocomplete-source')
    });
  };

  ready = function() {
    $("#field_fields").sortable({
      stop: function(event, ui) {
        window.updateOrder();
      }
    });
    $("#field_fields").disableSelection();
    window.updateOrder();
    init_autocomplete($('.name-search'));
  };

  window.updateOrder = function() {
    var $field_fields;
    $field_fields = $("#field_fields fieldset");
    $field_fields.each(function(index, element) {
      var $element;
      $element = $(element);
      $element.find('h3').html(index + 1);
      return $element.find('.field_order').val(index);
    });
  };

  $(document).on('click', 'form .remove_fields', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('fieldset').fadeOut();
    event.preventDefault();
    return window.updateOrder();
  });

  $(document).on('click', 'form .add_many_fields', function(event) {
    var $new_contact, new_row, regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    new_row = $(this).data('fields').replace(regexp, time);
    $new_contact = $(new_row);
    init_autocomplete($new_contact.find('.name-search'));
    $('#field_fields').append($new_contact);
    $('#no_field_fields').remove();
    event.preventDefault();
    return window.updateOrder();
  });

  $(document).on('click', 'form .add_fields', function(event) {
    var $new_contact;
    $.get('/apis/contact_field', function(data) {
      console.log(data);
      $('#field_fields').append(data);
      init_autocomplete($new_contact.find('.name-search'));
      return window.updateOrder();
    });
    $new_contact = $('#field_fields');
    init_autocomplete($new_contact.find('.name-search'));
    $('#field_fields').append($new_contact);
    $('#no_field_fields').remove();
    event.preventDefault();
    return window.updateOrder();
  });

  $(document).ready(ready);

  $(document).on('page:load', ready);

}).call(this);
