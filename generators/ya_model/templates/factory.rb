Factory.define(:<%= singular_name %>) do |v|
<%- attributes.each do |a| -%>
  <%- if a.reference? -%>
  v.<%= a.name %> { Factory(:<%= a.name %>) }
  <%- else -%>
  v.<%= a.name %> <%= a.default_value %>
  <%- end -%>
<%- end -%>
end
