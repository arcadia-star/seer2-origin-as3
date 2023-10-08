package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenLite;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.text.TextField;
   import org.taomee.utils.DomainUtil;
   
   public class MapDiLao
   {
      
      private static const LayerMaxWave:Array = [2,3,4,5,6,10];
      
      private static const Positions:Array = [new Point(770,350),new Point(700,400),new Point(800,400),new Point(570,440),new Point(716,440),new Point(850,440),new Point(520,490),new Point(596,529)];
      
      private static const limitIdList:Array = [203300,203310,203311,203299,203298];
      
      private static const timeBetweenLayer:Array = [0,5,10,20,30,24 * 60];
       
      
      private var _mapModel:MapModel;
      
      private var _resLibs:ApplicationDomain;
      
      private var currentWave:int = 0;
      
      private var currentLayer:int = 0;
      
      private var currentWavePetCount:int = 0;
      
      private var lastTime:int;
      
      private var currentWaveMaxPetCount:int;
      
      private var petList:Vector.<Mobile>;
      
      private var currentLayerContainer:MovieClip;
      
      private var currentLayerTxt:TextField;
      
      private var moveTip:MovieClip;
      
      private var petsToghter:MovieClip;
      
      public function MapDiLao(param1:MapModel)
      {
         super();
         this._mapModel = param1;
         this.init();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(this.petList)
         {
            _loc1_ = 0;
            while(_loc1_ < this.petList.length)
            {
               this.petList[_loc1_].removeEventListener(MouseEvent.CLICK,this.toFight);
               MobileManager.removeMobile(this.petList[_loc1_],MobileType.MODEL_PET);
               _loc1_++;
            }
         }
         if(this.currentLayerContainer)
         {
            DisplayObjectUtil.removeFromParent(this.currentLayerContainer);
            this.currentLayerContainer = null;
         }
         if(this.moveTip)
         {
            DisplayObjectUtil.removeFromParent(this.currentLayerContainer);
            TweenLite.killTweensOf(this.moveTip);
            this.moveTip = null;
         }
      }
      
      private function init() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("mapLayerGame/MapLayerGameDiLao"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLibs = param1.domain;
            initMap();
         });
      }
      
      private function test() : void
      {
         var mc:MovieClip = null;
         mc = this.getMovie("releaseMC") as MovieClip;
         this._mapModel.content.addChild(mc);
         mc.x = 300;
         MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(mc);
            AlertManager.showAlert("成功通过这层地牢",function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,1221);
            });
         });
      }
      
      private function initMap() : void
      {
         SwapManager.swapItem(2017,1,function():void
         {
            requestData();
         },function(param1:uint):void
         {
            var mc:MovieClip = null;
            var errorcode:uint = param1;
            mc = getMovie("releaseMC") as MovieClip;
            _mapModel.content.addChild(mc);
            mc.x = 300;
            MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
            {
               DisplayObjectUtil.removeFromParent(mc);
               AlertManager.showAlert("成功通过这层地牢",function():void
               {
                  SceneManager.changeScene(SceneType.LOBBY,1221);
               });
            });
         });
      }
      
      private function requestData() : void
      {
         ActiveCountManager.requestActiveCountList(limitIdList,function(param1:Parser_1142):void
         {
            currentLayer = param1.infoVec[0];
            currentWave = param1.infoVec[1];
            currentWavePetCount = param1.infoVec[2];
            lastTime = param1.infoVec[3];
            currentWaveMaxPetCount = param1.infoVec[4];
            analyseData();
         });
      }
      
      private function analyseData() : void
      {
         var mc:MovieClip = null;
         var count:int = 0;
         if(this.currentLayer == 6)
         {
            mc = this.getMovie("releaseMC") as MovieClip;
            this._mapModel.content.addChild(mc);
            mc.x = 300;
            MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
            {
               DisplayObjectUtil.removeFromParent(mc);
               SwapManager.swapItem(2019);
               AlertManager.showAlert("你已经打完所有层，现在可以开始重新冒险了",function():void
               {
                  SceneManager.changeScene(SceneType.LOBBY,1221);
               });
            });
            return;
         }
         if(this.currentWave == 0)
         {
            count = this.lastTime + timeBetweenLayer[this.currentLayer] * 60 - TimeManager.getServerTime();
            if(count > 0)
            {
               AlertManager.showAlert("你已经打完该层，等cd时间结束再进行下一层");
               return;
            }
         }
         if(this.currentWavePetCount == this.currentWaveMaxPetCount)
         {
            if(this.currentWave == LayerMaxWave[this.currentLayer] - 1)
            {
               this.displayBossTip();
            }
            else
            {
               this.displayNormalTip();
            }
         }
         this.addPets();
         this.addLayerTxt();
         this.addPetToghter();
      }
      
      private function addPetToghter() : void
      {
         this.petsToghter = this.getMovie("petsToghter") as MovieClip;
         this._mapModel.content.addChild(this.petsToghter);
         this.petsToghter.x = 721 + 50 + 50;
         this.petsToghter.y = 294;
      }
      
      private function addLayerTxt() : void
      {
         this.currentLayerContainer = this.getMovie("currentLayerContainer") as MovieClip;
         this._mapModel.content.addChild(this.currentLayerContainer);
         this.currentLayerContainer.x = LayerManager.stage.stageWidth / 2 - this.currentLayerContainer.width / 2;
         this.currentLayerContainer.y = 70;
         this.currentLayerTxt = this.currentLayerContainer["currentLayerTxt"];
         this.currentLayerTxt.text = (this.currentLayer + 1).toString();
      }
      
      private function displayBossTip() : void
      {
         this.moveTip = this.getMovie("BossTip") as MovieClip;
         this._mapModel.content.addChild(this.moveTip);
         this.moveTip.x = 100;
         this.moveTip.y = 300;
         TweenLite.to(this.moveTip,3,{
            "y":100,
            "onComplete":function():void
            {
               TweenLite.killTweensOf(moveTip);
               DisplayObjectUtil.removeFromParent(moveTip);
            }
         });
      }
      
      private function displayNormalTip() : void
      {
         this.moveTip = this.getMovie("NormalTip") as MovieClip;
         this._mapModel.content.addChild(this.moveTip);
         this.moveTip.x = 100;
         this.moveTip.y = 300;
         TweenLite.to(this.moveTip,3,{
            "y":100,
            "onComplete":function():void
            {
               TweenLite.killTweensOf(moveTip);
               DisplayObjectUtil.removeFromParent(moveTip);
            }
         });
      }
      
      private function addPets() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Mobile = null;
         this.petList = new Vector.<Mobile>();
         if(this.currentWave == LayerMaxWave[this.currentLayer] - 1)
         {
            _loc1_ = 635;
         }
         else
         {
            _loc1_ = 634;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.currentWavePetCount)
         {
            _loc2_ = new Mobile();
            this.petList.push(_loc2_);
            this.petList[_loc3_].resourceUrl = URLUtil.getNpcSwf(_loc1_);
            this.petList[_loc3_].buttonMode = true;
            this.petList[_loc3_].addEventListener(MouseEvent.CLICK,this.toFight);
            this.petList[_loc3_].setPostion(Positions[_loc3_]);
            MobileManager.addMobile(this.petList[_loc3_],MobileType.NPC);
            _loc3_++;
         }
      }
      
      private function toFight(param1:MouseEvent) : void
      {
         if(this.currentWave == LayerMaxWave[this.currentLayer] - 1)
         {
            FightManager.startFightWithWild(631);
         }
         else
         {
            FightManager.startFightWithWild(630);
         }
      }
      
      private function getMovie(param1:String) : DisplayObject
      {
         if(this._resLibs)
         {
            return DomainUtil.getDisplayObject(param1,this._resLibs);
         }
         return null;
      }
   }
}
