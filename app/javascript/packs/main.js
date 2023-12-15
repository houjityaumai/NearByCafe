// 位置情報を取得する
navigator.geolocation.getCurrentPosition(successCallback, errorCallback);

// 取得に成功した場合の処理
function successCallback(position){
  // 緯度を取得
  let latitude = position.coords.latitude;
  console.log(latitude)
  // 経度を取得
  let longitude = position.coords.longitude;
  console.log(longitude)
};

// 取得に失敗した場合の処理
function errorCallback(error){
  alert("位置情報が取得できませんでした");
};


// $(function(){
//   var gamescore = localStorage.getItem('score');
//   localStorage.clear();
// //  localStorageを用いて他のファイルの変数を持ってきてgamescoreへ代入しています。
//   $.ajax({
//     url: '/games/new',  
//     type: 'GET',
//     dataType: 'html',
//     async: true,
//     data: {
//       score: gamescore,
//     },
//   });
// });


