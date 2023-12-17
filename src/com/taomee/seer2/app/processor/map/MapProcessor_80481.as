package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class MapProcessor_80481 extends MapProcessor
   {
      
      private static const FOR_LIST:Array = [250414];
      
      private static const FIGHT_LIST:Vector.<int> = Vector.<int>([1635,1636]);
      
      private static const SEAT_POS:Vector.<Point> = Vector.<Point>([new Point(200 + 515,400 - 120),new Point(300 + 537,600 - 316)]);
      
      private static const PET_ID:int = 90;
      
      public static var mcState:Array = [0,0];
       
      
      private var _resLib:ApplicationDomain;
      
      private var _mapModel:MapModel;
      
      private var _npc:Mobile;
      
      private var _npc1:Mobile;
      
      private var _par:Parser_1142;
      
      public function MapProcessor_80481(param1:MapModel)
      {
         super(param1);
         this._mapModel = param1;
      }
      
      private function getURL(param1:Function = null) : void
      {
         var callBack:Function = param1;
         QueueLoader.load(URLUtil.getActivityAnimation("leiLuoHomeGloryAct/LeiLuoHomeGloryAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            if(callBack != null)
            {
               callBack();
            }
         });
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return DomainUtil.getMovieClip(param1,this._resLib);
         }
         return null;
      }
      
      override public function init() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && FIGHT_LIST[1] == FightManager.currentFightRecord.initData.positionIndex)
         {
            TweenNano.delayedCall(2,function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
               if(FightManager.fightWinnerSide == FightSide.RIGHT)
               {
                  ModuleManager.showAppModule("LeiLuoHomeGloryFailPanel");
               }
               else
               {
                  ModuleManager.showAppModule("LeiLuoHomeGloryActPanel");
               }
            });
            return;
         }
         this.getURL(function():void
         {
            update(function():void
            {
               var mc:MovieClip = null;
               if(_par.infoVec[0] == 1)
               {
                  if(mcState[0] == 0)
                  {
                     mc = getMovie("SceneMc0");
                     _mapModel.front.addChild(mc);
                     MovieClipUtil.playMc(mc,2,mc.totalFrames,function():void
                     {
                        mcState[0] = 1;
                        DisplayUtil.removeForParent(mc);
                        mc = null;
                        createNpc();
                        SeatTipsManager.registerSeat(SEAT_POS[0],80481);
                     });
                  }
                  else
                  {
                     createNpc();
                     SeatTipsManager.registerSeat(SEAT_POS[0],80481);
                  }
               }
               if(_par.infoVec[0] == 2)
               {
                  if(mcState[1] == 0)
                  {
                     mc = getMovie("SceneMc1");
                     _mapModel.front.addChild(mc);
                     MovieClipUtil.playMc(mc,2,mc.totalFrames,function():void
                     {
                        mcState[1] = 1;
                        DisplayUtil.removeForParent(mc);
                        mc = null;
                        createNpc1();
                        SeatTipsManager.registerSeat(SEAT_POS[1],80481);
                     });
                  }
                  else
                  {
                     createNpc1();
                     SeatTipsManager.registerSeat(SEAT_POS[1],80481);
                  }
               }
            });
         });
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 160;
            this._npc.setPostion(new Point(715,505));
            this._npc.resourceUrl = URLUtil.getNpcSwf(910);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "奥古斯特";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      private function clearNpc() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         FightManager.startFightWithWild(FIGHT_LIST[0]);
      }
      
      private function onNpcClick1(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(911,"雷诺",[[0,"小弟多时不见了！在阿卡迪亚星球磨练这么久，能力不知有无长进，让我这个做哥哥的来检验下吧！"]],["开始切磋","准备一下"],[function():void
         {
            if(isHasPetByResId(PET_ID))
            {
               FightManager.startFightWithWild(FIGHT_LIST[1]);
            }
            else
            {
               ModuleManager.showAppModule("LeiLuoHomeGloryNotPetPanel");
            }
         }]);
      }
      
      private function isHasPetByResId(param1:int) : Boolean
      {
         var _loc3_:PetInfo = null;
         var _loc2_:Boolean = false;
         for each(_loc3_ in PetInfoManager.getAllBagPetInfo())
         {
            if(_loc3_.resourceId == param1)
            {
               _loc2_ = true;
               break;
            }
         }
         return _loc2_;
      }
      
      private function createNpc1() : void
      {
         if(!this._npc1)
         {
            this._npc1 = new Mobile();
            this._npc1.width = 100;
            this._npc1.height = 160;
            this._npc1.setPostion(new Point(835,485));
            this._npc1.resourceUrl = URLUtil.getNpcSwf(911);
            this._npc1.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc1.label = "雷诺";
            this._npc1.labelImage.y = -this._npc1.height - 10;
            this._npc1.buttonMode = true;
            MobileManager.addMobile(this._npc1,MobileType.NPC);
            this._npc1.addEventListener(MouseEvent.CLICK,this.onNpcClick1);
         }
      }
      
      private function clearNpc1() : void
      {
         if(this._npc1)
         {
            this._npc1.removeEventListener(MouseEvent.CLICK,this.onNpcClick1);
            DisplayUtil.removeForParent(this._npc1);
            this._npc1 = null;
         }
      }
      
      private function update(param1:Function = null) : void
      {
         var callBack:Function = param1;
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            _par = param1;
            if(callBack != null)
            {
               callBack();
            }
         });
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._resLib = null;
         this._par = null;
         this._mapModel = null;
         SeatTipsManager.removeSeat(SEAT_POS[0],80481);
         SeatTipsManager.removeSeat(SEAT_POS[1],80481);
         this.clearNpc();
         this.clearNpc1();
      }
   }
}
