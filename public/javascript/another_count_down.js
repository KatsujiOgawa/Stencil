
window.addEventListener('load', function(){
  // 最新投稿の定義
  const lastReview = document.getElementById("following_limit_date")
  // 設定したタイムリミットを取得し、エポックミリ秒換算
  const limitId = lastReview.getAttribute("data-following_limit_id")
  const oneDay = 24 * 60 * 60 * 1000;
  const days = oneDay * limitId;
  // 最新の投稿日時を定義
  let createDt = lastReview.getAttribute("data-following_created_at");
  let startDt = new Date(createDt);
  let startSec = startDt.getTime()
  
  // 投稿期限日の定義
  let endDt = new Date(startSec + days);
  let endSec = endDt.getTime();  

  // カウントダウン処理
  let id = setInterval(function(){
    // 1秒毎に現在時刻と期限日の差を計算
    let dt = new Date();
    let untilLimit = endSec - dt;
    untilLimit--;
    // 年月日時分秒に換算
    d = Math.floor(untilLimit / oneDay);
    h = Math.floor((untilLimit % oneDay) / (60 * 60 * 1000));
    m = Math.floor((untilLimit % oneDay) / (60 * 1000)) % 60;
    s = Math.floor((untilLimit % oneDay) / 1000) % 60 % 60;
    console.log(`${d}日${h}時間${m}分${s}秒`);
    
    // タイムリミットになったらカウントダウンを終了する条件分岐
    dt = new Date();
    if(dt.getTime() < endDt){
      d = Math.floor(untilLimit / oneDay);
      h = Math.floor((untilLimit % oneDay) / (60 * 60 * 1000));
      m = Math.floor((untilLimit % oneDay) / (60 * 1000)) % 60;
      s = Math.floor((untilLimit % oneDay) / 1000) % 60 % 60;
      lastReview.innerHTML = `${d}日${h}時間${m}分${s}秒`
    } else {
      clearInterval(id);
      console.log("Finish!");
      lastReview.innerHTML = `レビュー終了`
    }
  }, 1000);
})
