package com.taomee.seer2.app.actives {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.manager.MineManger;
import com.taomee.seer2.app.manager.SeatTipsManager;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.taomee.manager.EventManager;

public class PipeBigSulleyAct extends BaseActiveProcess {

    private static var _instance:PipeBigSulleyAct;


    private const BIRD_NUM_ID:uint = 203162;

    private const MINE_ID:uint = 262;

    private const BIRD_SEAT_LIST:Vector.<Point> = Vector.<Point>([new Point(265, 190), new Point(285, 210), new Point(319, 190)]);

    private const RES_ID:uint = 2;

    private const MAX_NUM:uint = 3;

    private var birdList:Vector.<MovieClip>;

    private var birdNest:MovieClip;

    private var outMc:MovieClip;

    private var front:Sprite;

    private var birdNum:uint;

    public function PipeBigSulleyAct() {
        super();
    }

    public static function getInstance():PipeBigSulleyAct {
        if (!_instance) {
            _instance = new PipeBigSulleyAct();
        }
        return _instance;
    }

    public function dispose():void {
        EventManager.removeEventListener("SHOW_BIRD", this.reqBirdNum);
        var _loc1_:int = 0;
        while (_loc1_ < this.MAX_NUM) {
            this.birdList[_loc1_].removeEventListener(MouseEvent.CLICK, this.getReward);
            _loc1_++;
        }
    }

    public function setup():void {
        this.front = SceneManager.active.mapModel.front;
        EventManager.addEventListener("SHOW_BIRD", this.reqBirdNum);
        this.loadResouse(this.RES_ID, this.getRes);
    }

    private function getRes():void {
        this.reqBirdNum();
        this.birdList = new Vector.<MovieClip>();
        var _loc1_:int = 0;
        while (_loc1_ < this.MAX_NUM) {
            this.birdList.push(_resLib.getMovieClip("Bird"));
            this.birdList[_loc1_].x = this.BIRD_SEAT_LIST[_loc1_].x;
            this.birdList[_loc1_].y = this.BIRD_SEAT_LIST[_loc1_].y;
            this.birdList[_loc1_].buttonMode = true;
            this.birdList[_loc1_].mouseChildren = false;
            this.birdList[_loc1_].stop();
            this.birdList[_loc1_].addEventListener(MouseEvent.CLICK, this.getReward);
            _loc1_++;
        }
        this.birdNest = _resLib.getMovieClip("BirdNest");
        this.birdNest.egg.visible = false;
        this.outMc = _resLib.getMovieClip("OutMc");
        this.outMc.stop();
        this.birdNest.buttonMode = true;
        this.birdNest.addEventListener(MouseEvent.CLICK, this.showPanel);
        this.birdNest.x = 267;
        this.birdNest.y = 206;
        this.front.addChild(this.birdNest);
    }

    private function showPanel(param1:MouseEvent):void {
        if (this.birdNum == 0) {
            ModuleManager.toggleModule(URLUtil.getAppModule("PipeBirdPanel"));
        }
    }

    private function getReward(param1:MouseEvent):void {
        var target:MovieClip;
        var event:MouseEvent = param1;
        SeatTipsManager.removeSeat(new Point(300, 190));
        target = event.target as MovieClip;
        DisplayObjectUtil.removeFromParent(target);
        target.stop();
        this.outMc.x = target.x;
        this.outMc.y = target.y;
        this.front.addChild(this.outMc);
        MovieClipUtil.playMc(this.outMc, 1, this.outMc.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(outMc);
            MineManger.getMineItem(MINE_ID, mineComplete);
        }, true);
    }

    private function mineComplete(param1:Parser_1060):void {
        param1.showResult();
        --this.birdNum;
        if (this.birdNum != 0) {
            this.birdNest.egg.visible = true;
        } else {
            this.birdNest.egg.visible = false;
        }
    }

    private function reqBirdNum(param1:Event = null):void {
        if (param1) {
            SeatTipsManager.registerSeat(new Point(300, 190));
        }
        ActiveCountManager.requestActiveCount(this.BIRD_NUM_ID, this.getBirdNum);
    }

    private function getBirdNum(param1:uint, param2:uint):void {
        this.birdNum = param2;
        if (this.birdNum != 0) {
            this.birdNest.egg.visible = true;
        } else {
            this.birdNest.egg.visible = false;
        }
        this.showBird();
    }

    private function showBird():void {
        var _loc1_:int = 0;
        while (_loc1_ < this.MAX_NUM) {
            if (_loc1_ < this.birdNum) {
                this.front.addChild(this.birdList[_loc1_]);
                this.birdList[_loc1_].play();
            } else {
                DisplayObjectUtil.removeFromParent(this.birdList[_loc1_]);
                this.birdList[_loc1_].stop();
            }
            _loc1_++;
        }
    }
}
}
