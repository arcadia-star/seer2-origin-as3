package com.taomee.seer2.app.pet {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.bubble.Bubble;
import com.taomee.seer2.app.actor.bubble.BubblePool;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.FightVerifyManager;
import com.taomee.seer2.app.pet.bubble.BubbleController;
import com.taomee.seer2.app.pet.bubble.IBubbleHost;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.effect.SpawnedPetPresentEffectPool;
import com.taomee.seer2.app.pet.effect.SpawnedPetSupriseEffectPool;
import com.taomee.seer2.core.entity.PathMobile;
import com.taomee.seer2.core.entity.constant.MoveStyle;
import com.taomee.seer2.core.entity.events.ActionEvent;
import com.taomee.seer2.core.entity.events.MoveEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;

public class SpawnedPet extends PathMobile implements IBubbleHost {

    protected static const MAX_IDEL_INTERVAL:int = 250;

    protected static const PERSONAL:String = "personal";

    protected static const STAND_DOWN:String = "standDown";

    protected static const ACTOR_CLOSE_DISTANCE:int = 20;


    protected var _petInfo:PetInfo;

    private var _positionIndex:int;

    private var _maxIdelTime:int;

    private var _idleTime:int;

    private var _actorTargetPoint:Point;

    private var _supriseEffect:MovieClip;

    private var _presendEffect:MovieClip;

    private var _presentEffectType:uint;

    private var _bubble:Bubble;

    protected var _shadow:Sprite;

    public function SpawnedPet(param1:int, param2:int, param3:int) {
        super();
        this._petInfo = new PetInfo();
        this._petInfo.resourceId = param1;
        this._petInfo.level = param3;
        this._positionIndex = param2;
        this.initialize();
    }

    public static function isSpawnedPosition(param1:int):Boolean {
        return param1 >= 0 && param1 <= 9;
    }

    private function initialize():void {
        this.setResource();
        this.showLabel();
        this.addClickEventListener();
        this.hideAimation();
        addEventListener(Event.ADDED_TO_STAGE, this.onAddToStage);
    }

    protected function setResource():void {
        this.buttonMode = true;
        this.mouseChildren = false;
        this.resourceUrl = URLUtil.getPetSwf(this._petInfo.resourceId);
    }

    private function hideAimation():void {
        (this.animation as DisplayObject).visible = false;
    }

    protected function showAnimation():void {
        (this.animation as DisplayObject).visible = true;
        BubbleController.getInstance().addBubbleHost(this);
        this.generateMaxIdelTime();
        this.addShadow();
    }

    protected function addShadow():void {
        this._shadow = UIManager.getSprite("UI_PetShadow");
        this._shadow.scaleX = this._shadow.scaleY = width / 40;
        addChildAt(this._shadow, 0);
    }

    private function onAddToStage(param1:Event):void {
        this.present();
    }

    protected function showLabel():void {
        setLabelStyle(13395456, 16777215);
        if (this._petInfo.level != 0) {
            this.label = "Lv" + this._petInfo.level + " " + this._petInfo.name;
        } else {
            this.label = "Lv???" + " " + this._petInfo.name;
        }
    }

    public function setDefinedLabel(param1:String):void {
        if (this._petInfo.level != 0) {
            this.label = "Lv" + this._petInfo.level + " " + param1;
        } else {
            this.label = "Lv???" + " " + param1;
        }
    }

    private function addClickEventListener():void {
        addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(param1:MouseEvent):void {
        if (FightVerifyManager.validateFightStart()) {
            this.stopAction();
            this.actorMoveClose();
            this.closeInteraction();
        } else {
            FightManager.autoFightFlag = false;
        }
        param1.stopImmediatePropagation();
    }

    private function closeInteraction():void {
        this.mouseEnabled = false;
    }

    private function openInteraction():void {
        this.mouseEnabled = true;
    }

    public function stopAction():void {
        this.stand();
        this.playSupriseEffect();
    }

    private function playSupriseEffect():void {
        this._supriseEffect = SpawnedPetSupriseEffectPool.checkout();
        this._supriseEffect.y = 0 - this.height + 20;
        this._supriseEffect.addEventListener(Event.ENTER_FRAME, this.onSuprisePlay);
        addChild(this._supriseEffect);
    }

    private function onSuprisePlay(param1:Event):void {
        if (this._supriseEffect.currentFrame == this._supriseEffect.totalFrames) {
            this.recycleSupriseEffect();
        }
    }

    private function recycleSupriseEffect():void {
        if (this._supriseEffect != null) {
            this._supriseEffect.removeEventListener(Event.ENTER_FRAME, this.onSuprisePlay);
            this._supriseEffect.stop();
            removeChild(this._supriseEffect);
            SpawnedPetSupriseEffectPool.checkin(this._supriseEffect);
            this._supriseEffect = null;
        }
    }

    private function actorMoveClose():void {
        var _loc2_:Actor = null;
        var _loc1_:Rectangle = new Rectangle(this.x - ACTOR_CLOSE_DISTANCE, this.y - ACTOR_CLOSE_DISTANCE, ACTOR_CLOSE_DISTANCE * 2, ACTOR_CLOSE_DISTANCE * 2);
        this._actorTargetPoint = this.generateWalkablePoint(_loc1_);
        if (this.isActorArrived(this._actorTargetPoint) == true) {
            this.startFight();
        } else {
            _loc2_ = ActorManager.getActor();
            _loc2_.addEventListener(MoveEvent.FINISHED, this.onActorReached, false, 1);
            _loc2_.runToLocation(this._actorTargetPoint.x, this._actorTargetPoint.y);
        }
    }

    private function isActorArrived(param1:Point):Boolean {
        var _loc2_:Actor = ActorManager.getActor();
        return _loc2_.isArrivedPosition(param1);
    }

    private function onActorReached(param1:MoveEvent):void {
        if (this.isActorArrived(this._actorTargetPoint) == true) {
            this.startFight();
        }
        this.removeActorEventListener();
        this.openInteraction();
        param1.stopImmediatePropagation();
    }

    private function removeActorEventListener():void {
        ActorManager.getActor().removeEventListener(MoveEvent.FINISHED, this.onActorReached);
    }

    protected function startFight():void {
        if (this._positionIndex != -1) {
            FightManager.startFightWithWild(this._positionIndex);
        }
    }

    protected function present():void {
        var _loc1_:Rectangle = new Rectangle(0, 0, LayerManager.root.width, LayerManager.root.height - 80);
        var _loc2_:Point = this.generateWalkablePoint(_loc1_);
        this.x = _loc2_.x;
        this.y = _loc2_.y;
        this.action = STAND_DOWN;
        this.playPresentEffect();
    }

    private function playPresentEffect():void {
        this._presentEffectType = this._petInfo.type;
        this._presendEffect = SpawnedPetPresentEffectPool.checkout(this._presentEffectType);
        if (this._presendEffect == null) {
            this.showAnimation();
            return;
        }
        this._presendEffect.x = this.x;
        this._presendEffect.y = this.y - 10;
        this._presendEffect.addEventListener(Event.ENTER_FRAME, this.onPresentEffectPlay);
        this.parent.addChild(this._presendEffect);
    }

    private function onPresentEffectPlay(param1:Event):void {
        if (Boolean(this._presendEffect) && this._presendEffect.currentFrame == this._presendEffect.totalFrames) {
            this.recylePresentEffect();
            this.showAnimation();
        }
    }

    private function recylePresentEffect():void {
        if (this._presendEffect != null) {
            this._presendEffect.removeEventListener(Event.ENTER_FRAME, this.onPresentEffectPlay);
            this._presendEffect.stop();
            SpawnedPetPresentEffectPool.checkin(this._presendEffect, this._presentEffectType);
            this._presendEffect = null;
        }
    }

    protected function generateWalkablePoint(param1:Rectangle):Point {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        do {
            _loc2_ = param1.x + Math.random() * param1.width;
            _loc3_ = param1.y + Math.random() * param1.height;
        }
        while (SceneManager.active.mapModel.canWalk(_loc2_, _loc3_) == false);

        return new Point(_loc2_, _loc3_);
    }

    override public function update():void {
        this.checkIdleState();
        super.update();
    }

    private function checkIdleState():void {
        if (this._maxIdelTime > 0 && this.moveStyle == MoveStyle.STAND) {
            ++this._idleTime;
            if (this._idleTime > MAX_IDEL_INTERVAL) {
                this.playIdelAnimation();
                this._idleTime = 0;
            } else if (this._idleTime > this._maxIdelTime) {
                this.randomWalk();
            }
        }
    }

    private function playIdelAnimation():void {
        addActionEventListener(ActionEvent.FINISHED, this.onActionEnd);
        this.action = PERSONAL;
    }

    private function onActionEnd(param1:ActionEvent):void {
        removeActionEventListener(ActionEvent.FINISHED, this.onActionEnd);
        this.randomWalk();
    }

    private function randomWalk():void {
        var _loc1_:Rectangle = new Rectangle(0, 0, LayerManager.root.width, LayerManager.root.height - 80);
        var _loc2_:Point = this.generateWalkablePoint(_loc1_);
        walkToLocation(_loc2_.x, _loc2_.y);
        this.generateMaxIdelTime();
    }

    private function generateMaxIdelTime():void {
        this._maxIdelTime = (MAX_IDEL_INTERVAL >> 1) + (MAX_IDEL_INTERVAL >> 1) * Math.random();
        this._idleTime = 0;
    }

    public function showBubble():void {
        this.checkInBubble();
        this._bubble = BubblePool.checkOut();
        var _loc1_:String = this.getSlogan();
        if (_loc1_ != "" && Boolean(_loc1_)) {
            this._bubble.show(this.getSlogan());
            this._bubble.addEventListener(Event.CLOSE, this.onBubbleDisappear);
            this._bubble.y = -this.height;
            addChild(this._bubble);
        }
    }

    private function getSlogan():String {
        var _loc1_:Vector.<String> = this._petInfo.getSloganVec();
        var _loc2_:int = Math.random() * _loc1_.length;
        return _loc2_ <= _loc1_.length - 1 ? _loc1_[_loc2_] : "";
    }

    private function onBubbleDisappear(param1:Event):void {
        this.checkInBubble();
    }

    private function checkInBubble():void {
        if (this._bubble != null) {
            this._bubble.removeEventListener(Event.CLOSE, this.onBubbleDisappear);
            BubblePool.checkIn(this._bubble);
            DisplayObjectUtil.removeFromParent(this._bubble);
            this._bubble = null;
        }
    }

    override public function dispose():void {
        BubbleController.getInstance().removeBubbleHost(this);
        this.recycleSupriseEffect();
        this.recylePresentEffect();
        this.removeActorEventListener();
        this.checkInBubble();
        super.dispose();
    }
}
}
