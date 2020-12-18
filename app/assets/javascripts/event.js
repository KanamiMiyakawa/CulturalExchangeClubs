$(function(){

  //イベントindexの詳細検索操作
  $('#extended-search').hide();

  $('#showSearchBtn').on('click', function() {
    $('#extended-search').slideDown('slow');
    $('#primal-submit').hide();
  });

  //読み込み時にオンラインが選択されていたら住所フォームをhideする
  if(document.forms.eventForm.event_online_true.checked){
    $('#address-form').hide();
  };

  //オンラインを選ぶと住所入力欄が消えるイベント
  $( '[name="event[online]"]:radio' ).change( function() {
    var radioval = $(this).val();
    if(radioval == "false"){
      $('#address-form').slideDown('slow');
    }else{
      $('#address-form').hide('slow');
    }
  });

  //言語フォーム追加用のhtmlを作成
  function buildField(index){
      var html = `<div class="language-form">
                    <h3 class="mb-3 mt-4 ml-3">参加者の言語 ${index+1}</h3>
                    <div class="event-new-content mb-5">
                    <div class="form-group">
                      <label for="event_event_languages_attributes_${index}_language_id">言語名</label>
                      <select class="form-control" name="event[event_languages_attributes][${index}][language_id]" id="event_event_languages_attributes_${index}_language_id">
                        <option value="1">どの言語でもOK！</option>
                        <option value="2">アイスランド語</option>
                        <option value="3">アイマラ語</option>
                        <option value="4">アイルランド語</option>
                        <option value="5">アヴァル語</option>
                        <option value="6">アヴェスター語</option>
                        <option value="7">アカン語</option>
                        <option value="8">アゼルバイジャン語</option>
                        <option value="9">アッサム語</option>
                        <option value="10">アファル語</option>
                        <option value="11">アブハズ語</option>
                        <option value="12">アフリカーンス語</option>
                        <option value="13">アムハラ語</option>
                        <option value="14">アラゴン語</option>
                        <option value="15">アラビア語</option>
                        <option value="16">アルバニア語</option>
                        <option value="17">アルメニア語</option>
                        <option value="18">イタリア語</option>
                        <option value="19">イディッシュ語</option>
                        <option value="20">イド語</option>
                        <option value="21">イヌクティトゥット語</option>
                        <option value="22">イヌピアック語</option>
                        <option value="23">イボ語</option>
                        <option value="24">インターリング</option>
                        <option value="25">インターリングア</option>
                        <option value="26">インドネシア語</option>
                        <option value="27">ウイグル語</option>
                        <option value="28">ウェールズ語</option>
                        <option value="29">ヴェンダ語</option>
                        <option value="30">ヴォラピュク</option>
                        <option value="31">ウォロフ語</option>
                        <option value="32">ウクライナ語</option>
                        <option value="33">ウズベク語</option>
                        <option value="34">ウルドゥー語</option>
                        <option value="35">エウェ語</option>
                        <option value="36">エストニア語</option>
                        <option value="37">エスペラント</option>
                        <option value="38">オジブウェー語</option>
                        <option value="39">オセット語</option>
                        <option value="40">オック語</option>
                        <option value="41">オランダ語</option>
                        <option value="42">オリヤー語</option>
                        <option value="43">オロモ語</option>
                        <option value="44">カザフ語</option>
                        <option value="45">カシミール語</option>
                        <option value="46">カタルーニャ語、バレンシア語</option>
                        <option value="47">カヌリ語</option>
                        <option value="48">ガリシア語</option>
                        <option value="49">カンナダ語</option>
                        <option value="50">キクユ語</option>
                        <option value="51">ギリシア語</option>
                        <option value="52">キルギス語</option>
                        <option value="53">グアラニー語</option>
                        <option value="54">グジャラート語</option>
                        <option value="55">クメール語</option>
                        <option value="56">グリーンランド語</option>
                        <option value="57">クリー語</option>
                        <option value="58">グルジア語</option>
                        <option value="59">クルド語</option>
                        <option value="60">クロアチア語</option>
                        <option value="61">クワニャマ語</option>
                        <option value="62">ケチュア語</option>
                        <option value="63">コーンウォール語</option>
                        <option value="64">コサ語</option>
                        <option value="65">コミ語</option>
                        <option value="66">コルシカ語</option>
                        <option value="67">コンゴ語</option>
                        <option value="68">サモア語</option>
                        <option value="69">サルデーニャ語</option>
                        <option value="70">サンゴ語</option>
                        <option value="71">サンスクリット</option>
                        <option value="72">ジャワ語</option>
                        <option value="73">ショナ語</option>
                        <option value="74">シンド語</option>
                        <option value="75">シンハラ語</option>
                        <option value="76">スウェーデン語</option>
                        <option value="77">ズールー語</option>
                        <option value="78">スコットランド・ゲール語</option>
                        <option value="79">スペイン語</option>
                        <option value="80">スロバキア語</option>
                        <option value="81">スロベニア語</option>
                        <option value="82">スワジ語</option>
                        <option value="83">スワヒリ語</option>
                        <option value="84">スンダ語</option>
                        <option value="85">セルビア語</option>
                        <option value="86">ソト語</option>
                        <option value="87">ソマリ語</option>
                        <option value="88">ゾンカ語</option>
                        <option value="89">タイ語</option>
                        <option value="90">タガログ語</option>
                        <option value="91">タジク語</option>
                        <option value="92">タタール語</option>
                        <option value="93">タヒチ語</option>
                        <option value="94">タミル語</option>
                        <option value="95">チェコ語</option>
                        <option value="96">チェチェン語</option>
                        <option value="97">チェワ語</option>
                        <option value="98">チベット語</option>
                        <option value="99">チャモロ語</option>
                        <option value="100">チュヴァシ語</option>
                        <option value="101">チワン語</option>
                        <option value="102">ツォンガ語</option>
                        <option value="103">ツワナ語</option>
                        <option value="104">ティグリニャ語</option>
                        <option value="105">ディベヒ語</option>
                        <option value="106">テルグ語</option>
                        <option value="107">デンマーク語</option>
                        <option value="108">ドイツ語</option>
                        <option value="109">トウィ語</option>
                        <option value="110">トルクメン語</option>
                        <option value="111">トルコ語</option>
                        <option value="112">トンガ語</option>
                        <option value="113">ナウル語</option>
                        <option value="114">ナバホ語</option>
                        <option value="115">ネパール語</option>
                        <option value="116">ノルウェー語</option>
                        <option value="117">ノルウェー語(ニーノシュク)</option>
                        <option value="118">ノルウェー語(ブークモール)</option>
                        <option value="119">パーリ語</option>
                        <option value="120">ハイチ語</option>
                        <option value="121">ハウサ語</option>
                        <option value="122">バシキール語</option>
                        <option value="123">パシュトー語</option>
                        <option value="124">バスク語</option>
                        <option value="125">ハンガリー語</option>
                        <option value="126">パンジャーブ語</option>
                        <option value="127">バンバラ語</option>
                        <option value="128">ビスラマ語</option>
                        <option value="129">ビハール語</option>
                        <option value="130">ヒリモツ語</option>
                        <option value="131">ビルマ語</option>
                        <option value="132">ヒンディー語</option>
                        <option value="133">フィジー語</option>
                        <option value="134">フィンランド語</option>
                        <option value="135">フェロー語</option>
                        <option value="136">フラニ語</option>
                        <option value="137">フランス語</option>
                        <option value="138">ブルガリア語</option>
                        <option value="139">ブルトン語</option>
                        <option value="140">ベトナム語</option>
                        <option value="141">ヘブライ語</option>
                        <option value="142">ベラルーシ語</option>
                        <option value="143">ペルシア語</option>
                        <option value="144">ヘレロ語</option>
                        <option value="145">ベンガル語</option>
                        <option value="146">ポーランド語</option>
                        <option value="147">ボスニア語</option>
                        <option value="148">ポルトガル語</option>
                        <option value="149">マーシャル語</option>
                        <option value="150">マオリ語</option>
                        <option value="151">マケドニア語</option>
                        <option value="152">マダガスカル語</option>
                        <option value="153">マラーティー語</option>
                        <option value="154">マラヤーラム語</option>
                        <option value="155">マルタ語</option>
                        <option value="156">マレー語</option>
                        <option value="157">マン島語</option>
                        <option value="158">モンゴル語</option>
                        <option value="159">ヨルバ語</option>
                        <option value="160">ラーオ語</option>
                        <option value="161">ラテン語</option>
                        <option value="162">ラトビア語</option>
                        <option value="163">リトアニア語</option>
                        <option value="164">リンガラ語</option>
                        <option value="165">リンブルフ語</option>
                        <option value="166">ルーマニア語、モルドバ語</option>
                        <option value="167">ルガンダ語</option>
                        <option value="168">ルクセンブルク語</option>
                        <option value="169">ルバ・カタンガ語</option>
                        <option value="170">ルワンダ語</option>
                        <option value="171">ルンディ語</option>
                        <option value="172">ロシア語</option>
                        <option value="173">ロマンシュ語</option>
                        <option value="174">ワロン語</option>
                        <option value="175">ンドンガ語</option>
                        <option value="176">英語</option>
                        <option value="177">韓国語</option>
                        <option value="178">古代教会スラヴ語、教会スラヴ語</option>
                        <option value="179">四川彝語</option>
                        <option value="180">西フリジア語</option>
                        <option value="181">中国語(広東語)</option>
                        <option value="182">中国語(標準語)</option>
                        <option value="183">南ンデベレ語</option>
                        <option value="184">日本語</option>
                        <option value="185">北ンデベレ語</option>
                        <option value="186">北部サーミ語</option>
                      </select>
                    </div>
                    <div class="form-group">
                      <label for="event_event_languages_attributes_${index}_max">最大人数</label>
                      <input min="1" class="form-control" type="number" name="event[event_languages_attributes][${index}][max]" id="event_event_languages_attributes_${index}_max">
                    </div>
                    </div>
                    </div>`;
      return html;
  }

  let fileIndex = $(".language-form").length;

  //言語フォームを追加するイベント
  $(".add-form-btn").on("click", function() {
    $(".languages-form").append(buildField(fileIndex));
    fileIndex += 1;
  })
})
