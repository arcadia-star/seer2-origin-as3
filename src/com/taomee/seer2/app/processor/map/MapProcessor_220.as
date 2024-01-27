package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.gameRule.fish.FishRule_220;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

public class MapProcessor_220 extends TitleMapProcessor {


    private var _openVortex:MovieClip;

    private var _stepOne:MovieClip;

    private var _stepTwo:MovieClip;

    private var _stepThree:MovieClip;

    private var _stepFour:MovieClip;

    private var _snailAnimation:MovieClip;

    private var _fortuneCat:MovieClip;

    private var _piggyBank:MovieClip;

    private var _cat:MovieClip;

    private var _costCnt:int;

    private var _spawnPetIndexVec:Vector.<uint>;

    private var _snailClickCount:int = 0;

    private var _showPopCnt:int = 0;

    private var _fishRule:FishRule_220;

    private var hit:MouseClickHintSprite;

    public function MapProcessor_220(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initFortuneCat();
        this.initVortex();
        this.initSnail();
        this.addPetSpawnCommandListener();
        this.initFishPoint();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_135);
        MobileManager.getMobile(164, MobileType.NPC).addEventListener(MouseEvent.CLICK, this.onClickHandler);
    }

    private function onClickHandler(param1:MouseEvent):void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_257);
    }

    private function initFishPoint():void {
        this._fishRule = new FishRule_220();
        this._fishRule.init(_map);
    }

    private function initFortuneCat():void {
        this._fortuneCat = _map.content["fortuneCat"];
        this._piggyBank = this._fortuneCat["bank"];
        this._cat = this._fortuneCat["cat"];
        this._piggyBank.buttonMode = true;
        this._piggyBank.addEventListener(MouseEvent.CLICK, this.onPiggyBankClick);
        this.resetFortuneCat();
    }

    private function resetFortuneCat():void {
        this._costCnt = 0;
        this._fortuneCat.gotoAndStop(1);
        this._fortuneCat.addEventListener("stop40", this.showPopPanel);
        this._fortuneCat.addEventListener("stop73", this.showPopPanel);
        this._fortuneCat.addEventListener("end", this.showFortuneCat);
    }

    private function showPopPanel(param1:Event):void {
        if (param1.type == "stop40") {
            this._fortuneCat.removeEventListener("stop40", this.showPopPanel);
            if (this._showPopCnt < 2) {
                this.showPopUp();
            }
        } else if (param1.type == "stop73") {
            this._fortuneCat.removeEventListener("stop73", this.showPopPanel);
            if (this._showPopCnt < 3) {
                this.showPopUp();
            }
        }
        param1.stopImmediatePropagation();
    }

    private function showPopUp():void {
        AlertManager.showPiggyBankAlert(this._costCnt, this.onPutMoney);
        ++this._showPopCnt;
    }

    private function showFortuneCat(param1:Event):void {
        this._fortuneCat.removeEventListener("end", this.showFortuneCat);
        this._cat.addEventListener(MouseEvent.CLICK, this.onCatClick);
        this._cat.buttonMode = true;
        param1.stopImmediatePropagation();
    }

    private function onCatClick(param1:MouseEvent):void {
        this._cat.buttonMode = false;
        var _loc2_:XML = <npc id="405" resId="405" name="阿宝" dir="1" width="25" height="90" pos="841,288"
                              actorPos="821,288" path="">
            <dialog npcId="405" npcName="阿宝" transport="1,300,400">
                <branch id="default">
                    <node emotion="0"><![CDATA[我要旅行！我要旅行！ 壮士！你能帮我一起打工存旅行费吗？]]></node>
                    <reply action="close"><![CDATA[还是去吹吹风吧。]]></reply>
                </branch>
            </dialog>
            <functionality>
            </functionality>
        </npc>;
        var _loc3_:NpcDefinition = new NpcDefinition(_loc2_);
        _loc3_.addFunctionalityUnitAt(<node type="" name="我要和你单挑" params="abao_220_0"/>, 0);
        DialogPanel.showForNpc(_loc3_);
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.toDia);
    }

    private function toDia(param1:DialogPanelEvent):void {
        var _loc2_:String = (param1.content as DialogPanelEventData).params;
        if (_loc2_ == "abao_220_0") {
            FightManager.startFightWithWild(22);
        }
    }

    private function onPiggyBankClick(param1:MouseEvent):void {
        if (this.hit) {
            DisplayObjectUtil.removeFromParent(this.hit);
        }
        if (this._costCnt < 3) {
            this.showPopUp();
        }
    }

    private function onPutMoney():void {
        ++this._costCnt;
        switch (this._costCnt) {
            case 1:
                this._fortuneCat.gotoAndPlay(2);
                break;
            case 2:
                this._fortuneCat.gotoAndPlay(41);
                break;
            case 3:
                this._fortuneCat.gotoAndPlay(74);
        }
    }

    private function removeFortunecat():void {
        this._piggyBank.removeEventListener(MouseEvent.CLICK, this.onPiggyBankClick);
        this._fortuneCat.removeEventListener("stop40", this.showPopPanel);
        this._fortuneCat.removeEventListener("stop73", this.showPopPanel);
        this._fortuneCat.removeEventListener("end", this.showFortuneCat);
        this._cat.removeEventListener(MouseEvent.CLICK, this.onCatClick);
        this._fortuneCat = null;
        this._piggyBank = null;
        this._cat = null;
    }

    private function initSnail():void {
        this._snailAnimation = _map.content["snailAnimation"];
        this._snailAnimation.gotoAndPlay(1);
        initInteractor(this._snailAnimation);
        this._snailAnimation.addEventListener(MouseEvent.CLICK, this.onSnailClick);
    }

    private function onSnailClick(param1:MouseEvent):void {
        if (this._snailClickCount == 0) {
            ++this._snailClickCount;
            this._snailAnimation.gotoAndPlay("点击");
        } else if (this._snailClickCount == 1) {
            ++this._snailClickCount;
            this._snailAnimation.gotoAndPlay("点击1");
            this._snailAnimation.removeEventListener(MouseEvent.CLICK, this.onSnailClick);
        }
    }

    private function initVortex():void {
        this._openVortex = _map.content["openVortex"];
        this._openVortex.gotoAndStop(1);
        this._openVortex.addEventListener(Event.FRAME_CONSTRUCTED, this.onVortexUpdate);
    }

    private function onVortexUpdate(param1:Event):void {
        switch (this._openVortex.currentFrame) {
            case 1:
                this.initStepOne();
                break;
            case 2:
                this.initStepTwo();
                break;
            case 3:
                this.initStepThree();
                break;
            case 4:
                this.initStepFour();
        }
    }

    private function initStepOne():void {
        this._stepOne = this._openVortex["stepOne"];
        initInteractor(this._stepOne);
        this._stepOne.addEventListener(MouseEvent.CLICK, this.onStepClick);
    }

    private function onStepClick(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.target as MovieClip;
        _loc2_.gotoAndPlay("点击");
        closeInteractor(_loc2_);
        _loc2_.removeEventListener(MouseEvent.CLICK, this.onStepClick);
        _loc2_.addEventListener(Event.ENTER_FRAME, this.gotoNextSetp);
    }

    private function gotoNextSetp(param1:Event):void {
        var _loc2_:MovieClip = param1.target as MovieClip;
        if (_loc2_.currentFrame == _loc2_.totalFrames) {
            _loc2_.removeEventListener(Event.ENTER_FRAME, this.gotoNextSetp);
            this._openVortex.nextFrame();
        }
    }

    private function removeStepEnterFrameEventListener():void {
        if (this._stepOne != null) {
            this._stepOne.removeEventListener(Event.ENTER_FRAME, this.gotoNextSetp);
        }
        if (this._stepTwo != null) {
            this._stepTwo.removeEventListener(Event.ENTER_FRAME, this.gotoNextSetp);
        }
        if (this._stepThree != null) {
            this._stepThree.removeEventListener(Event.ENTER_FRAME, this.gotoNextSetp);
        }
        if (this._stepFour != null) {
            this._stepFour.removeEventListener(Event.ENTER_FRAME, this.gotoNextSetp);
        }
    }

    private function initStepTwo():void {
        this._stepTwo = this._openVortex["stepTwo"];
        initInteractor(this._stepTwo);
        this._stepTwo.addEventListener(MouseEvent.CLICK, this.onStepClick);
    }

    private function initStepThree():void {
        this._stepThree = this._openVortex["stepThree"];
        initInteractor(this._stepThree);
        this._stepThree.addEventListener(MouseEvent.CLICK, this.onStepClick);
    }

    private function initStepFour():void {
        this._stepFour = this._openVortex["stepFour"];
        initInteractor(this._stepFour);
        this._stepFour.addEventListener(MouseEvent.CLICK, this.onStepClick);
        this._openVortex.removeEventListener(Event.FRAME_CONSTRUCTED, this.onVortexUpdate);
    }

    private function addPetSpawnCommandListener():void {
        Connection.addCommandListener(CommandSet.PET_SPAWN_1103, this.onPetSpawn);
    }

    private function onPetSpawn(param1:MessageEvent):void {
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc7_:int = 0;
        this._spawnPetIndexVec = new Vector.<uint>();
        var _loc2_:IDataInput = param1.message.getRawData().clone();
        var _loc3_:int = int(_loc2_.readUnsignedInt());
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc5_ = int(_loc2_.readUnsignedByte());
            _loc6_ = int(_loc2_.readUnsignedInt());
            _loc7_ = int(_loc2_.readUnsignedShort());
            this._spawnPetIndexVec.push(_loc5_);
            _loc4_++;
        }
    }

    private function removePetSpawnCommmandListener():void {
        Connection.removeCommandListener(CommandSet.PET_SPAWN_1103, this.onPetSpawn);
    }

    override public function dispose():void {
        this.removeStepEnterFrameEventListener();
        this.removePetSpawnCommmandListener();
        this.removeFortunecat();
        this._openVortex.removeEventListener(Event.FRAME_CONSTRUCTED, this.onVortexUpdate);
        this._openVortex = null;
        this._stepOne = null;
        this._stepTwo = null;
        this._stepThree = null;
        this._stepFour = null;
        this._snailAnimation = null;
        this._fishRule.dispose();
        this._fishRule = null;
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.toDia);
        super.dispose();
    }
}
}
