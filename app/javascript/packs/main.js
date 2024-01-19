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


// script.js
document.addEventListener('DOMContentLoaded', function() {
    var currentIndex = 0;
    var maxIndex = <%= @shops.length - 1 %>;
  
    function changeImage() {
      // 現在の画像を非表示
      document.getElementById('image' + (currentIndex + 1)).style.display = 'none';
  
      // インデックスを更新
      currentIndex = (currentIndex + 1) % (maxIndex + 1);
  
      // 次の画像を表示
      document.getElementById('image' + (currentIndex + 1)).style.display = 'block';
    }
  
    // 5000ミリ秒（5秒）ごとに画像を切り替える
    setInterval(changeImage, 5000);
  });
  