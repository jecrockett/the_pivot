<div class="col s12 m3 l3">
  <div class="box">
    <h5 class="center">Cause Supporters</h5>
    <div class="collection">
      <% @supporters.each do |supporter| %>
        <%= link_to supporter.title, user_path(supporter), class: "collection-item btn" %>
      <% end %>
    </div>
  </div>
</div>
