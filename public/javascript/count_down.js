
window.addEventListener('load', function(){
  const latestReview = document.getElementById("limit_date")
  const limitId = latestReview.getAttribute("data-limit_id")
  const oneDay = 24 * 60 * 60 * 1000;
  const days = oneDay * limitId;
  let createDt = latestReview.getAttribute("data-created_at");
  let startDt = new Date(createDt);
  let startSec = startDt.getTime()
  
  let id = setInterval(function(){
    let dt = new Date();
    let endDt = new Date(startSec + days);
    let endSec = endDt.getTime();  
    let untilLimit = endSec - dt;
    console.log(startDt)
    console.log(endDt)
    untilLimit--;    
    d = Math.floor(untilLimit / oneDay);
    h = Math.floor((untilLimit % oneDay) / (60 * 60 * 1000));
    m = Math.floor((untilLimit % oneDay) / (60 * 1000)) % 60;
    s = Math.floor((untilLimit % oneDay) / 1000) % 60 % 60;
    // console.log(untilLimit);
    console.log(`${d}日${h}時間${m}分${s}秒`);
    
    // 現在日時と終了日時を比較
    dt = new Date();
    if(dt.getTime() < endDt){
      d = Math.floor(untilLimit / oneDay);
      h = Math.floor((untilLimit % oneDay) / (60 * 60 * 1000));
      m = Math.floor((untilLimit % oneDay) / (60 * 1000)) % 60;
      s = Math.floor((untilLimit % oneDay) / 1000) % 60 % 60;
      latestReview.innerHTML = `${d}日${h}時間${m}分${s}秒`
    } else {
      clearInterval(id);
      console.log("Finish!");
      latestReview.innerHTML = `レビュー終了`
    }
  }, 1000);
})

// ・修正点予定ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
// ページの読み込みから1秒カウントダウンの表示までラグがある。
// 最新投稿のcreated_atが秒単位で取得できていない