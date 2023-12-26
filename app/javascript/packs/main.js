// // 位置情報を取得する
// navigator.geolocation.getCurrentPosition(successCallback, errorCallback);

// // 取得に成功した場合の処理
// function successCallback(position){
//   if (navigator.geolocation){
//     navigator.geolocation.getCurrentPosition(
//       function(position){
//         $.ajax({
//           url: "/shops/position",
//           type: "GET",
//           async: true,
//           data:{latitude : position.coords.latitude,
//                 longitude : position.coords.longitude,
//           } 
//         })
//       }
//     )
//   }
//   // window.location.href = "/shops/position?latitude=" + position.coords.latitude + "&longitude=" + position.coords.longitude

// };



// // 取得に失敗した場合の処理
// function errorCallback(error){
//   alert("位置情報が取得できませんでした");
// };


// //描画処理
// // function redraw(){
// //   $(".shops").html( `<% @shops.each do |shop| %>
// //               <p><%= shop.name %>/<%= shop.address %></p>
// //           <% end %>`)
// // }

// //todo 更新された@shops