package com.taomee.seer2.app.processor.activity.christmas.npc {
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.InteractiveRewardManager;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.activity.christmas.IChristmasNpc;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class ChristmasLaAo implements IChristmasNpc {


    private var _res:ResourceLibrary;

    private var _npc:Mobile;

    private var _laAoMC:MovieClip;

    private var _mouseHint:MouseClickHintSprite;

    public function ChristmasLaAo(param1:ResourceLibrary) {
        super();
        this._res = param1;
    }

    public function playAnimation():void {
        var url:String = String(URLUtil.getActivityAnimation("9/5"));
        MovieClipUtil.playFullScreen(url, function ():void {
            initMouse();
            initNpc();
        }, false);
    }

    private function initMouse():void {
        DisplayObjectUtil.removeFromParent(this._mouseHint);
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.x = 331;
        this._mouseHint.y = 295;
        LayerManager.topLayer.addChild(this._mouseHint);
    }

    public function initNpc():void {
        var _loc1_:XML = <npc id="427" resId="427" name="拉奥" dir="1" width="25" height="50" pos="331,313"
                              actorPos="334,325" path="">
            <eventHandler>
                <mouseOver>
                    <HandlerShowNpcSlogan><![CDATA[我人品好 勤劳善良我有爱心]]></HandlerShowNpcSlogan>
                </mouseOver>
            </eventHandler>
        </npc>;
        var _loc2_:NpcDefinition = new NpcDefinition(_loc1_);
        this._npc = MobileManager.createNpc(_loc2_);
        this._npc.buttonMode = true;
        this._npc.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        DisplayObjectUtil.removeFromParent(this._mouseHint);
        NpcDialog.show(427, "拉奥", [[0, "爸爸的爸爸的爸爸的妈妈的妈妈告诉我！我一脸明星相！我自己也这么认为的！这个给你！咱们庆祝下！"]], ["长远的历史……"], [function ():void {
            _npc.removeEventListener(MouseEvent.CLICK, onClick);
            _laAoMC = _res.getMovieClip("laaoComplete");
            LayerManager.topLayer.addChild(_laAoMC);
            _laAoMC.x = _npc.x;
            _laAoMC.y = _npc.y;
            _npc.visible = false;
            InteractiveRewardManager.requestReward(55, function (param1:Parser_1060):void {
                var parser:Parser_1060 = param1;
                MovieClipUtil.playMc(_laAoMC, 2, _laAoMC.totalFrames, function ():void {
                    if (parser.activityCount == 0) {
                        AlertManager.showAlert("哎哟！我们M5的礼物都被你拿光光了啦！明天再给你吧！");
                    } else {
                        parser.showResult();
                    }
                    DisplayUtil.removeForParent(_laAoMC);
                });
            });
        }]);
    }

    public function dispose():void {
        DisplayObjectUtil.removeFromParent(this._mouseHint);
        this._mouseHint = null;
        if (this._npc) {
            this._npc.addEventListener(MouseEvent.CLICK, this.onClick);
            DisplayUtil.removeForParent(this._npc);
        }
        this._npc = null;
        DisplayUtil.removeForParent(this._laAoMC);
        this._laAoMC = null;
    }
}
}
