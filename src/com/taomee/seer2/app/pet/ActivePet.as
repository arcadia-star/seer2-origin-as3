package com.taomee.seer2.app.pet {
import com.taomee.seer2.app.pet.bubble.BubbleController;
import com.taomee.seer2.app.pet.bubble.IBubbleHost;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.effect.SpawnedPetPresentEffectPool;
import com.taomee.seer2.core.entity.PathMobile;
import com.taomee.seer2.core.entity.events.ActionEvent;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

public class ActivePet extends PathMobile implements IBubbleHost {

    protected static const PERSONAL:String = "personal";

    protected static const START_WALK:String = "startWalk";


    protected var _petInfo:PetInfo;

    private var _point:Point;

    private var _targetPoint:Point;

    private var _petId:uint;

    private var _presentEffectType:uint;

    private var _presendEffect:MovieClip;

    private var _shadow:Sprite;

    private var _mc:MovieClip;

    public function ActivePet(param1:Point, param2:uint) {
        super();
        this._petId = param2;
        this._petInfo = new PetInfo();
        this._petInfo.resourceId = param2;
        this._point = param1;
        this.initialize();
    }

    private function initialize():void {
        this.setResource();
        this.showLabel();
        this.addClickEventListener();
        addEventListener(Event.ADDED_TO_STAGE, this.onAddToStage);
    }

    protected function setResource():void {
        this.buttonMode = true;
        this.mouseChildren = false;
        this.resourceUrl = URLUtil.getPetSwf(this._petInfo.resourceId);
    }

    private function showLabel():void {
        setLabelStyle(13395456, 16777215);
    }

    private function addClickEventListener():void {
    }

    private function onAddToStage(param1:Event):void {
        this.present();
    }

    protected function present():void {
        this.x = this._point.x;
        this.y = this._point.y;
        this.action = START_WALK;
        this.showAnimation();
    }

    private function playPresentEffect():void {
        this._presentEffectType = this._petInfo.type;
        this._presendEffect = SpawnedPetPresentEffectPool.checkout(this._presentEffectType);
        this._presendEffect.x = this.x;
        this._presendEffect.y = this.y - 10;
        this._presendEffect.addEventListener(Event.ENTER_FRAME, this.onPresentEffectPlay);
        this.parent.addChild(this._presendEffect);
    }

    private function onPresentEffectPlay(param1:Event):void {
        if (this._presendEffect.currentFrame == this._presendEffect.totalFrames) {
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

    protected function showAnimation():void {
        (this.animation as DisplayObject).visible = true;
        BubbleController.getInstance().addBubbleHost(this);
        this.randomWalk();
        this.addShadow();
    }

    private function addShadow():void {
        this._shadow = UIManager.getSprite("UI_PetShadow");
        this._shadow.scaleX = this._shadow.scaleY = width / 40;
        addChildAt(this._shadow, 0);
    }

    private function playIdelAnimation():void {
        addActionEventListener(ActionEvent.FINISHED, this.onActionEnd, false, 1);
        this.action = PERSONAL;
    }

    private function onActionEnd(param1:ActionEvent):void {
        removeActionEventListener(ActionEvent.FINISHED, this.onActionEnd, false);
        this.randomWalk();
    }

    private function randomWalk():void {
        walkToLocation(this._targetPoint.x, this._targetPoint.y);
    }

    public function showBubble():void {
    }

    public function set targetPoint(param1:Point):void {
        this._targetPoint = param1;
    }

    public function get targetMC():MovieClip {
        return this._mc;
    }
}
}
