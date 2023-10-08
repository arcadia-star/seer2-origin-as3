package com.taomee.seer2.app.processor.activity.earthSearchAct
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.dialog.functionality.BaseUnit;
   import com.taomee.seer2.app.dialog.functionality.CustomUnit;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class EarthSearchThreeLayer
   {
       
      
      private const RES_ID:Vector.<int> = Vector.<int>([836,837]);
      
      private const POS:Vector.<int> = Vector.<int>([700,390]);
      
      private const BOSS_INDEX:int = 1423;
      
      private var _resLib:ApplicationDomain;
      
      private var _mapModel:MapModel;
      
      private var _npc:Mobile;
      
      public function EarthSearchThreeLayer(param1:MapModel)
      {
         super();
         this._mapModel = param1;
         this.getURL();
      }
      
      private function getURL() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("earthAct/earthAct1"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            init();
         });
      }
      
      private function init() : void
      {
         EarthSearchThreeManager.inistance().addObj(this);
         this.stateHandle();
      }
      
      private function stateHandle() : void
      {
         var state:int;
         EarthSearchThreeManager.inistance().state = 0;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               EarthSearchThreeManager.inistance().state = 2;
               ServerMessager.addMessage("恭喜通过地核层！");
               SceneManager.changeScene(SceneType.LOBBY,70);
               TweenNano.delayedCall(2,function():void
               {
                  ModuleManager.showAppModule("EarthSeachActPanel");
               });
               return;
            }
            EarthSearchThreeManager.inistance().state = 1;
         }
         state = EarthSearchThreeManager.inistance().state;
         if(state == 0)
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.EARTH_SEARCH_ACT,this.onGetServer,false);
         }
         if(state == 1 || state == 2)
         {
            this.addNpc(this.RES_ID[1],this.POS);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      private function onGetServer(param1:ServerBuffer) : void
      {
         var server:ServerBuffer = param1;
         var isComplete:Boolean = Boolean(server.readDataAtPostion(10));
         if(isComplete)
         {
            this.addNpc(this.RES_ID[1],this.POS);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
         else
         {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("earthSearchAct/EarthSearchAct2"),function():void
            {
               ServerBufferManager.updateServerBuffer(ServerBufferType.EARTH_SEARCH_ACT,10,1);
               addNpc(RES_ID[0],POS);
               _npc.addEventListener(MouseEvent.CLICK,onNpcClick0);
            },true,true,2,false);
         }
      }
      
      private function onNpcClick0(param1:Event) : void
      {
         var _scenMc:MovieClip = null;
         var evt:Event = param1;
         this.removeNpc();
         _scenMc = this.getMovie("sceneTalk_1");
         this._mapModel.front.addChild(_scenMc);
         MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_scenMc);
            _scenMc = null;
            addNpc(RES_ID[1],POS);
            _npc.addEventListener(MouseEvent.CLICK,onNpcClick);
         },true);
      }
      
      private function onNpcClick(param1:Event) : void
      {
         DialogPanel.showForSimple(837,"地心兽",[[0,"没想到你们机器人智商这么低，轻而易举就被我的小弟骗进来了！哈哈哈！让你尝尝地球BOSS的厉害！"]],"我再准备下");
         this.addUinit();
      }
      
      private function addUinit() : void
      {
         var _loc3_:BaseUnit = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         DialogPanel.addFunctionalityBox();
         var _loc1_:Vector.<String> = Vector.<String>(["兑换地心兽","电池购买","地核层规则","直接挑战"]);
         var _loc2_:Vector.<String> = Vector.<String>(["EarthSwap1","EarthBuy1","EarthRule1","EarthReadyGo1"]);
         if(EarthSearchThreeManager.inistance().state == 2)
         {
            _loc1_.pop();
            _loc2_.pop();
         }
         for each(_loc5_ in _loc1_)
         {
            if(_loc4_ <= 2)
            {
               _loc3_ = new CustomUnit(FunctionalityType.MODULE,_loc5_,_loc2_[_loc4_]);
            }
            else
            {
               _loc3_ = new CustomUnit(FunctionalityType.ACTIVE,_loc5_,_loc2_[_loc4_]);
            }
            DialogPanel.functionalityBox.addUnit(_loc3_);
            _loc4_++;
         }
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onUint);
      }
      
      public function removeUnit() : void
      {
         var _loc2_:BaseUnit = null;
         var _loc3_:String = null;
         var _loc1_:Vector.<String> = Vector.<String>(["兑换地心兽","电池购买","地核层规则","直接挑战"]);
         for each(_loc3_ in _loc1_)
         {
            _loc2_ = DialogPanel.functionalityBox.getUnit(_loc3_);
            if(_loc2_)
            {
               DialogPanel.functionalityBox.removeUnit(_loc2_);
            }
         }
      }
      
      private function onUint(param1:DialogPanelEvent) : void
      {
         var _loc2_:String = String(param1.content.params);
         if(_loc2_ == "EarthSwap1")
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("EarthGetPetPanel"),"打开...");
         }
         if(_loc2_ == "EarthBuy1")
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("EarthItemBuyPanel"),"打开...");
         }
         if(_loc2_ == "EarthRule1")
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("EarthActIntroduceThreePanel"),"打开规则...");
         }
         if(_loc2_ == "EarthReadyGo1")
         {
            FightManager.startFightWithWild(this.BOSS_INDEX);
         }
      }
      
      private function addNpc(param1:int, param2:Vector.<int>) : void
      {
         if(this._npc)
         {
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
         this._npc = new Mobile();
         this._npc.resourceUrl = URLUtil.getNpcSwf(param1);
         this._npc.x = param2[0];
         this._npc.y = param2[1];
         this._npc.buttonMode = true;
         this._npc.scaleX = -1;
         this.showMouseHintAtMonster(this._npc);
         MobileManager.addMobile(this._npc,MobileType.NPC);
      }
      
      private function showMouseHintAtMonster(param1:Mobile) : void
      {
         var _loc2_:MouseClickHintSprite = new MouseClickHintSprite();
         _loc2_.y = -_loc2_.height - 100;
         _loc2_.x = (param1.width - param1.width) / 2;
         param1.addChild(_loc2_);
      }
      
      public function addBoss() : void
      {
         this.addNpc(this.RES_ID[1],this.POS);
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
      }
      
      public function removeNpc() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick0);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
      }
      
      private function playSceneTalk(param1:String, param2:Function = null, param3:Array = null) : void
      {
         var _scenMc:MovieClip = null;
         var resName:String = param1;
         var afterFunc:Function = param2;
         var params:Array = param3;
         _scenMc = this.getMovie(resName);
         this._mapModel.front.addChild(_scenMc);
         MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_scenMc);
            _scenMc = null;
            if(afterFunc != null)
            {
               afterFunc.call(params);
            }
         },true);
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return DomainUtil.getMovieClip(param1,this._resLib);
         }
         return null;
      }
      
      public function dispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onUint);
         DialogPanel.functionalityBox.clear();
         this.removeNpc();
         this._mapModel = null;
         this._resLib = null;
      }
   }
}
