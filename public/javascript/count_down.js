
// window.addEventListener('load', function(){
//   const latestReview = document.getElementById("limit_date")
//   const limitId = latestReview.getAttribute("data-limit_id")
//   const oneDay = 24 * 60 * 60 * 1000;
//   const days = oneDay * limitId;

//   let dt = new Date();
//   let createDt = latestReview.getAttribute("data-created_at");
//   let startDt = new Date(createDt).getTime();
//   let endDt = new Date(startDt + days * 1000).getTime();
//   // let endSec = endDt.getTime();
//   console.log(dt);
//   console.log(startDt);
//   console.log(endDt);
//   let cnt = (endDt - dt);

//   let id = setInterval(function(){
//     cnt--;
//     console.log(cnt);
//     // 現在日時と終了日時を比較
//     dt = new Date();
//     if(dt.getTime() >= endDt){
//       clearInterval(id);
//       console.log("Finish!");
//     }
//   }, 1000);
// })








// document.addEventListener('DOMContentLoaded', function() {
//   var Timer = function(saleStartTime, saleEndTime, endMessage, outputDestination) {
//     this.saleStartTime = saleStartTime;
//     this.saleEndTime = saleEndTime;
//     this.endMessage = endMessage;
//     this.outputDestination = outputDestination;
//   };
  
//   Timer.prototype.countDown = function() {
//     var saleStartTime = new Date(this.saleStartTime);
//     var saleEndTime = new Date(this.saleEndTime);
//     var oneDay = 24 * 60 * 60 * 1000;
//     var countDownTimer = document.getElementById(this.outputDestination);
//     var endMessage = this.endMessage;
//     var currentTimeCD = new Date();
//     var untilStartTime = new Date();
//     var untilFinishTime = new Date();
//     var d = 0;
//     var h = 0;
//     var m = 0;
//     var s = 0;

//     setInterval(calculateTime, 1000);

//     function calculateTime() {
//       currentTimeCD = new Date();
//         untilStartTime = saleStartTime - currentTimeCD;
//         untilFinishTime = saleEndTime - currentTimeCD;

//         if (currentTimeCD < saleStartTime) {
//           d = Math.floor(untilStartTime / oneDay);
//           h = Math.floor((untilStartTime % oneDay) / (60 * 60 * 1000));
//           m = Math.floor((untilStartTime % oneDay) / (60 * 1000)) % 60;
//           s = Math.floor((untilStartTime % oneDay) / 1000) % 60 % 60;
//         } else {
//           d = Math.floor(untilFinishTime / oneDay);
//           h = Math.floor((untilFinishTime % oneDay) / (60 * 60 * 1000));
//           m = Math.floor((untilFinishTime % oneDay) / (60 * 1000)) % 60;
//           s = Math.floor((untilFinishTime % oneDay) / 1000) % 60 % 60;
//         }

//         showTime();
//       }

//       function showTime() {
//         if (currentTimeCD < saleStartTime) {
//           countDownTimer.innerHTML
//           = '開始まで' + d + '日' + h + '時間' + m + '分' + s + '秒';
//         } else if (currentTimeCD >= saleStartTime && currentTimeCD <= saleEndTime) {
//           countDownTimer.innerHTML
//           = 'あと' + d + '日' + h + '時間' + m + '分' + s + '秒' + 'で終了';
//         } else {
//           countDownTimer.innerHTML = endMessage;
//         }
//       }
//     }
    
//     var myTimer = new Timer('2021/1/11 00:00:00', '2100/12/31 23:59:59', '終了！', 'timer');
//     myTimer.countDown();
//   }, false)














window.addEventListener('load', function(){
  const latestReview = document.getElementById("limit_date")
  const limitId = latestReview.getAttribute("data-limit_id")
  const oneDay = 24 * 60 * 60 * 1000;
  const days = oneDay * limitId;
  let createDt = latestReview.getAttribute("data-created_at");
  let startDt = new Date(createDt).getTime();
  
  
  // console.log(dt);
  let id = setInterval(function(){
    let dt = new Date();
    let endDt = new Date(startDt + days);
    let endSec = endDt.getTime();
    // console.log(startDt);
    // console.log(endSec);

  
    let untilLimit = endSec - dt;
  
    untilLimit--;
    
    d = Math.floor(untilLimit / oneDay);
    h = Math.floor((untilLimit % oneDay) / (60 * 60 * 1000));
    m = Math.floor((untilLimit % oneDay) / (60 * 1000)) % 60;
    s = Math.floor((untilLimit % oneDay) / 1000) % 60 % 60;
    // 現在日時と終了日時を比較
    
    
    // console.log(untilLimit);
    console.log(`${d}日${h}時間${m}分${s}秒`);

    latestReview.innerHTML = `レビュー期限：${d}日${h}時間${m}分${s}秒`
    
    dt = new Date();
    if(dt.getTime() < endDt){
      d = Math.floor(untilLimit / oneDay);
      h = Math.floor((untilLimit % oneDay) / (60 * 60 * 1000));
      m = Math.floor((untilLimit % oneDay) / (60 * 1000)) % 60;
      s = Math.floor((untilLimit % oneDay) / 1000) % 60 % 60;
    } else {
      clearInterval(id);
      console.log("Finish!");
    }
  }, 1000);
})
