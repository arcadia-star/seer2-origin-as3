package com.taomee.seer2.app.processor.activity.darkAct
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.dialog.functionality.BaseUnit;
   import com.taomee.seer2.app.dialog.functionality.CustomUnit;
   import com.taomee.seer2.app.inventory.ItemManager;
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
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class DarkThreeLayer
   {
       
      
      private const EQUIP:Vector.<int> = Vector.<int>([400081,400082,400083,400084,400085]);
      
      private const TIP:Vector.<String> = Vector.<String>(["死神头部魂魄","死神手部魂魄","死神腰部魂魄","死神腿部魂魄","死神背部魂魄"]);
      
      private const RES_ID:Vector.<int> = Vector.<int>([130,563]);
      
      private const POS:Vector.<int> = Vector.<int>([700,390]);
      
      private const BOSS_INDEX:int = 363;
      
      private var _resLib:ApplicationDomain;
      
      private var _mapModel:MapModel;
      
      private var _npc:Mobile;
      
      public function DarkThreeLayer(param1:MapModel)
      {
         super();
         this._mapModel = param1;
         TweenNano.delayedCall(3,this.equipUpdate);
         this.getURL();
      }
      
      private function getURL() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("darkAct/darkAct1"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            var _loc2_:int = 0;
            while(_loc2_ < 5)
            {
               TooltipManager.addCommonTip(_mapModel.content["equip"]["equip" + _loc2_],TIP[_loc2_]);
               _loc2_++;
            }
            init();
         });
      }
      
      private function init() : void
      {
         DarkThreeManager.inistance().addObj(this);
         this.stateHandle();
      }
      
      private function stateHandle() : void
      {
         DarkThreeManager.inistance().state = 0;
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT)
         {
            DarkThreeManager.inistance().state = 2;
         }
         var _loc1_:int = DarkThreeManager.inistance().state;
         if(_loc1_ == 0)
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.DARK_THREE,this.onGetServer,false);
         }
         if(_loc1_ == 1 || _loc1_ == 2)
         {
            this.addNpc(this.RES_ID[1],this.POS);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      private function onGetServer(param1:ServerBuffer) : void
      {
         var server:ServerBuffer = param1;
         var isComplete:Boolean = Boolean(server.readDataAtPostion(1));
         if(isComplete)
         {
            this.addNpc(this.RES_ID[1],this.POS);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
         else
         {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("darkThreeFull"),function():void
            {
               var _scenMc:MovieClip = null;
               ServerBufferManager.updateServerBuffer(ServerBufferType.DARK_THREE,1,1);
               addNpc(RES_ID[0],POS);
               _scenMc = getMovie("sceneTalk_1");
               _mapModel.front.addChild(_scenMc);
               MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(_scenMc);
                  _scenMc = null;
                  removeNpc();
                  _scenMc = getMovie("sceneAnim_1");
                  _mapModel.front.addChild(_scenMc);
                  MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
                  {
                     DisplayUtil.removeForParent(_scenMc);
                     _scenMc = null;
                     addNpc(RES_ID[1],POS);
                     _scenMc = getMovie("sceneTalk_2");
                     _mapModel.front.addChild(_scenMc);
                     MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
                     {
                        DisplayUtil.removeForParent(_scenMc);
                        _scenMc = null;
                        DarkThreeManager.inistance().state = 1;
                        _npc.addEventListener(MouseEvent.CLICK,onNpcClick);
                     },true);
                  },true);
               },true);
            },true,true,2,false);
         }
      }
      
      private function onNpcClick(param1:Event) : void
      {
         DialogPanel.showForSimple(563,"死神",[[0,"暗黑的力量如此强大，撒旦王会统治整个星球的。哈哈哈"]],"我再准备下");
         this.addUinit();
      }
      
      private function addUinit() : void
      {
         var _loc3_:BaseUnit = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         DialogPanel.addFunctionalityBox();
         var _loc1_:Vector.<String> = Vector.<String>(["兑换部件","购买暗月石","第三层规则","挑战死神"]);
         var _loc2_:Vector.<String> = Vector.<String>(["swap1","buy1","rule1","readyGo1"]);
         if(DarkThreeManager.inistance().state == 2)
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
         var _loc1_:Vector.<String> = Vector.<String>(["兑换部件","购买暗月石","第三层规则","挑战死神"]);
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
         if(_loc2_ == "swap1")
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("DarkDeathSwapPetPanel"),"打开...");
         }
         if(_loc2_ == "buy1")
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("BuyPropPanel"),"",{
               "itemId":400078,
               "canBatch":true,
               "isLimitNum":false,
               "buyType":"mi",
               "itemType":"hideShop"
            });
         }
         if(_loc2_ == "rule1")
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("DarkDeathRule2Panel"),"打开规则...");
         }
         if(_loc2_ == "readyGo1")
         {
            FightManager.startFightWithWild(this.BOSS_INDEX);
         }
      }
      
      public function equipUpdate() : void
      {
         if(this._mapModel == null)
         {
            return;
         }
         ItemManager.requestItemList(function():void
         {
            var _loc1_:int = 0;
            var _loc2_:int = 0;
            for each(_loc2_ in EQUIP)
            {
               if(ItemManager.getItemByReferenceId(_loc2_))
               {
                  if(_mapModel)
                  {
                     (_mapModel.content["equip"]["equip" + _loc1_] as MovieClip).gotoAndStop(2);
                  }
               }
               _loc1_++;
            }
         });
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
         MobileManager.addMobile(this._npc,MobileType.NPC);
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
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            TooltipManager.remove(this._mapModel.content["equip"]["equip" + _loc1_]);
            _loc1_++;
         }
         this.removeNpc();
         this._mapModel = null;
         this._resLib = null;
      }
   }
}
