<% js = escape_javascript(
  render(
    :partial => 'televisions/navigation/modelcount',
  )
) %>
$("#results").html("<%= js %>");
