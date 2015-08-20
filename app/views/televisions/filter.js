<% js = escape_javascript(
  render(
    :partial => 'televisions/modelcount',
  )
) %>
$("#results").html("<%= js %>");
