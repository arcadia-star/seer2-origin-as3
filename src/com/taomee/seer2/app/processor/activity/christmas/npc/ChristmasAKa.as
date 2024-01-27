package com.taomee.seer2.app.processor.activity.christmas.npc {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.activity.christmas.ChristmasThreeProcess;
import com.taomee.seer2.app.processor.activity.christmas.IChristmasNpc;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class ChristmasAKa implements IChristmasNpc {


    private var _npc:Mobile;

    private var _mouseHint:MouseClickHintSprite;

    public function ChristmasAKa() {
        super();
    }

    public function playAnimation():void {
        var url:String = String(URLUtil.getActivityAnimation("9/2"));
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
        var _loc1_:XML = <npc id="424" resId="424" name="阿卡" dir="1" width="25" height="50" pos="331,313"
                              actorPos="334,325" path="">
            <eventHandler>
                <mouseOver>
                    <HandlerShowNpcSlogan><![CDATA[烦躁！烦躁！我到底会不会是圣诞代言人？]]></HandlerShowNpcSlogan>
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
        NpcDialog.show(424, "阿卡", [[0, "矮油……伦家会不会是圣诞代言人呢？我好烦躁哦！你陪我打一场如何？"]], ["囧！大男人还发嗲！（对战）", "（不对战)"], [function ():void {
            ChristmasThreeProcess.isActivityFight = true;
            FightManager.startFightWithWild(42);
        }]);
    }

    public function dispose():void {
        DisplayObjectUtil.removeFromParent(this._mouseHint);
        this._mouseHint = null;
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onClick);
            DisplayUtil.removeForParent(this._npc);
        }
        this._npc = null;
    }
}
}
