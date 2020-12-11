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
      const html = `<div class="language-form">
                    <h3 class="mb-3 mt-4 ml-3">参加者の言語 ${index+1}</h3>
                    <div class="event-new-content mb-5">
                    <div class="form-group">
                      <label for="event_event_languages_attributes_${index}_language_id">言語名</label>
                      <select class="form-control" name="event[event_languages_attributes][${index}][language_id]" id="event_event_languages_attributes_${index}_language_id">
                        <option value="557">どの言語でもOK！</option>
                        <option value="558">アイスランド語</option>
                        <option value="559">アイマラ語</option>
                        <option value="560">アイルランド語</option>
                        <option value="561">アヴァル語</option>
                        <option value="562">アヴェスター語</option>
                        <option value="563">アカン語</option>
                        <option value="564">アゼルバイジャン語</option>
                        <option value="565">アッサム語</option>
                        <option value="566">アファル語</option>
                        <option value="567">アブハズ語</option>
                        <option value="568">アフリカーンス語</option>
                        <option value="569">アムハラ語</option>
                        <option value="570">アラゴン語</option>
                        <option value="571">アラビア語</option>
                        <option value="572">アルバニア語</option>
                        <option value="573">アルメニア語</option>
                        <option value="574">イタリア語</option>
                        <option value="575">イディッシュ語</option>
                        <option value="576">イド語</option>
                        <option value="577">イヌクティトゥット語</option>
                        <option value="578">イヌピアック語</option>
                        <option value="579">イボ語</option>
                        <option value="580">インターリング</option>
                        <option value="581">インターリングア</option>
                        <option value="582">インドネシア語</option>
                        <option value="583">ウイグル語</option>
                        <option value="584">ウェールズ語</option>
                        <option value="585">ヴェンダ語</option>
                        <option value="586">ヴォラピュク</option>
                        <option value="587">ウォロフ語</option>
                        <option value="588">ウクライナ語</option>
                        <option value="589">ウズベク語</option>
                        <option value="590">ウルドゥー語</option>
                        <option value="591">エウェ語</option>
                        <option value="592">エストニア語</option>
                        <option value="593">エスペラント</option>
                        <option value="594">オジブウェー語</option>
                        <option value="595">オセット語</option>
                        <option value="596">オック語</option>
                        <option value="597">オランダ語</option>
                        <option value="598">オリヤー語</option>
                        <option value="599">オロモ語</option>
                        <option value="600">カザフ語</option>
                        <option value="601">カシミール語</option>
                        <option value="602">カタルーニャ語、バレンシア語</option>
                        <option value="603">カヌリ語</option>
                        <option value="604">ガリシア語</option>
                        <option value="605">カンナダ語</option>
                        <option value="606">キクユ語</option>
                        <option value="607">ギリシア語</option>
                        <option value="608">キルギス語</option>
                        <option value="609">グアラニー語</option>
                        <option value="610">グジャラート語</option>
                        <option value="611">クメール語</option>
                        <option value="612">グリーンランド語</option>
                        <option value="613">クリー語</option>
                        <option value="614">グルジア語</option>
                        <option value="615">クルド語</option>
                        <option value="616">クロアチア語</option>
                        <option value="617">クワニャマ語</option>
                        <option value="618">ケチュア語</option>
                        <option value="619">コーンウォール語</option>
                        <option value="620">コサ語</option>
                        <option value="621">コミ語</option>
                        <option value="622">コルシカ語</option>
                        <option value="623">コンゴ語</option>
                        <option value="624">サモア語</option>
                        <option value="625">サルデーニャ語</option>
                        <option value="626">サンゴ語</option>
                        <option value="627">サンスクリット</option>
                        <option value="628">ジャワ語</option>
                        <option value="629">ショナ語</option>
                        <option value="630">シンド語</option>
                        <option value="631">シンハラ語</option>
                        <option value="632">スウェーデン語</option>
                        <option value="633">ズールー語</option>
                        <option value="634">スコットランド・ゲール語</option>
                        <option value="635">スペイン語</option>
                        <option value="636">スロバキア語</option>
                        <option value="637">スロベニア語</option>
                        <option value="638">スワジ語</option>
                        <option value="639">スワヒリ語</option>
                        <option value="640">スンダ語</option>
                        <option value="641">セルビア語</option>
                        <option value="642">ソト語</option>
                        <option value="643">ソマリ語</option>
                        <option value="644">ゾンカ語</option>
                        <option value="645">タイ語</option>
                        <option value="646">タガログ語</option>
                        <option value="647">タジク語</option>
                        <option value="648">タタール語</option>
                        <option value="649">タヒチ語</option>
                        <option value="650">タミル語</option>
                        <option value="651">チェコ語</option>
                        <option value="652">チェチェン語</option>
                        <option value="653">チェワ語</option>
                        <option value="654">チベット語</option>
                        <option value="655">チャモロ語</option>
                        <option value="656">チュヴァシ語</option>
                        <option value="657">チワン語</option>
                        <option value="658">ツォンガ語</option>
                        <option value="659">ツワナ語</option>
                        <option value="660">ティグリニャ語</option>
                        <option value="661">ディベヒ語</option>
                        <option value="662">テルグ語</option>
                        <option value="663">デンマーク語</option>
                        <option value="664">ドイツ語</option>
                        <option value="665">トウィ語</option>
                        <option value="666">トルクメン語</option>
                        <option value="667">トルコ語</option>
                        <option value="668">トンガ語</option>
                        <option value="669">ナウル語</option>
                        <option value="670">ナバホ語</option>
                        <option value="671">ネパール語</option>
                        <option value="672">ノルウェー語</option>
                        <option value="673">ノルウェー語(ニーノシュク)</option>
                        <option value="674">ノルウェー語(ブークモール)</option>
                        <option value="675">パーリ語</option>
                        <option value="676">ハイチ語</option>
                        <option value="677">ハウサ語</option>
                        <option value="678">バシキール語</option>
                        <option value="679">パシュトー語</option>
                        <option value="680">バスク語</option>
                        <option value="681">ハンガリー語</option>
                        <option value="682">パンジャーブ語</option>
                        <option value="683">バンバラ語</option>
                        <option value="684">ビスラマ語</option>
                        <option value="685">ビハール語</option>
                        <option value="686">ヒリモツ語</option>
                        <option value="687">ビルマ語</option>
                        <option value="688">ヒンディー語</option>
                        <option value="689">フィジー語</option>
                        <option value="690">フィンランド語</option>
                        <option value="691">フェロー語</option>
                        <option value="692">フラニ語</option>
                        <option value="693">フランス語</option>
                        <option value="694">ブルガリア語</option>
                        <option value="695">ブルトン語</option>
                        <option value="696">ベトナム語</option>
                        <option value="697">ヘブライ語</option>
                        <option value="698">ベラルーシ語</option>
                        <option value="699">ペルシア語</option>
                        <option value="700">ヘレロ語</option>
                        <option value="701">ベンガル語</option>
                        <option value="702">ポーランド語</option>
                        <option value="703">ボスニア語</option>
                        <option value="704">ポルトガル語</option>
                        <option value="705">マーシャル語</option>
                        <option value="706">マオリ語</option>
                        <option value="707">マケドニア語</option>
                        <option value="708">マダガスカル語</option>
                        <option value="709">マラーティー語</option>
                        <option value="710">マラヤーラム語</option>
                        <option value="711">マルタ語</option>
                        <option value="712">マレー語</option>
                        <option value="713">マン島語</option>
                        <option value="714">モンゴル語</option>
                        <option value="715">ヨルバ語</option>
                        <option value="716">ラーオ語</option>
                        <option value="717">ラテン語</option>
                        <option value="718">ラトビア語</option>
                        <option value="719">リトアニア語</option>
                        <option value="720">リンガラ語</option>
                        <option value="721">リンブルフ語</option>
                        <option value="722">ルーマニア語、モルドバ語</option>
                        <option value="723">ルガンダ語</option>
                        <option value="724">ルクセンブルク語</option>
                        <option value="725">ルバ・カタンガ語</option>
                        <option value="726">ルワンダ語</option>
                        <option value="727">ルンディ語</option>
                        <option value="728">ロシア語</option>
                        <option value="729">ロマンシュ語</option>
                        <option value="730">ワロン語</option>
                        <option value="731">ンドンガ語</option>
                        <option value="732">英語</option>
                        <option value="733">韓国語</option>
                        <option value="734">古代教会スラヴ語、教会スラヴ語</option>
                        <option value="735">四川彝語</option>
                        <option value="736">西フリジア語</option>
                        <option value="737">中国語(広東語)</option>
                        <option value="738">中国語(標準語)</option>
                        <option value="739">南ンデベレ語</option>
                        <option value="740">日本語</option>
                        <option value="741">北ンデベレ語</option>
                        <option value="742">北部サーミ語</option>
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
