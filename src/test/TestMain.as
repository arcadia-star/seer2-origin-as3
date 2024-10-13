package test {


import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;

import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import seer2.next.utils.TextUtils;

public class TestMain extends Sprite {
    private static var ROOT:String = "http://127.0.0.1:7337/seer2/";

    /**
     * 可以在这里测试UI展示效果，测试前需要启动新版本客户端
     */
    public function TestMain() {
        init(function () {
            var _tip = FightUIManager.getMovieClip("UI_FightSkillTip");
            _tip.x = 200;
            _tip.y = 200;
            addChild(_tip);
            var _descriptionTxt = _tip["txtDes"];
            var _loc1_ = new TextFormat("", 10);
            _descriptionTxt.selectable = true;
            _descriptionTxt.mouseEnabled = true;
            _descriptionTxt.defaultTextFormat = _loc1_;
            _descriptionTxt.autoSize = TextFieldAutoSize.LEFT;
            _descriptionTxt.wordWrap = true;
            _descriptionTxt.border = true;
            var text = TextUtils.replaceColorFormat("很好！[br]把这封问候信带给[ffcc00]草目氏族的酋长[-]，表达我们[ff0000]希望结盟的意愿[-]。记住，随机应变，结盟，只能成功！表达我们希望结盟的意愿。[br]记住，随机应变，[00ff00]结盟[-]，只能成功！");
            _descriptionTxt.htmlText = TextUtils.wrapHtmlFontSize(text);
            _descriptionTxt.htmlText = 1231311;
            var _back = _tip["backMc"];
            if (_descriptionTxt.height > 50) {
                _back.height = _descriptionTxt.height + 20;
            } else {
                _back.height = 110.55;
            }
            _descriptionTxt.y = 2 - _back.height;
            TooltipManager.addMultipleTip(_descriptionTxt, text);

        })
    }

    private function init(cb:Function) {
        var dll:DLLLoader = new DLLLoader();
        LayerManager.setup(this);
        TooltipManager.setup();
        dll.addEventListener(Event.COMPLETE, function () {
            trace("load: DLL success")
            RequestPool.sendSwfRequest(ROOT + "res/ui/UI.swf", function (data) {
                trace("load: UI success")
                UIManager.setup(data);
                RequestPool.sendSwfRequest(ROOT + "res/ui/UI_Arena.swf", function (data) {
                    trace("load: UI_Arena success")
                    FightUIManager.setup(data);
                    cb();
                });
            });
        })
        dll.doLoad(XML('<dll><item name="核心类库（四合一）" path="dll/Seer2CoreDLL.swf"/></dll>'), ROOT, false);
    }
}
}
