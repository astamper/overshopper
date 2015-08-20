<% js = escape_javascript(
  render(
    :partial => 'televisions/list',
    :locals => { :televisions => @televisions }
  )
) %>
$("#results").html("<%= js %>");
