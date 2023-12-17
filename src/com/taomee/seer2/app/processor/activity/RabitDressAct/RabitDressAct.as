package com.taomee.seer2.app.processor.activity.RabitDressAct
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.morphSystem.MorphManager;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class RabitDressAct
   {
      
      public static var state:Array = [0,0,0,0];
       
      
      private var _mapModel:MapModel;
      
      private var _npc:MovieClip;
      
      private var _resLib:ApplicationDomain;
      
      private const NPC_POS:Vector.<int> = Vector.<int>([730,160]);
      
      private const ITEM:int = 603064;
      
      private const POS_INDEX:int = 424;
      
      private const SWAP_ID:int = 1252;
      
      public function RabitDressAct(param1:MapModel)
      {
         super();
         this._mapModel = param1;
         this.getURL();
      }
      
      private function getURL() : void
      {
         MobileManager.showMoileVec(MobileType.SPAWNED_PET);
         QueueLoader.load(URLUtil.getActivityAnimation("rabitDressAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            init();
         });
      }
      
      private function init() : void
      {
         this.addMonster();
         this.addNpc();
         if(RabitDressAct.state[0] == 0)
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitch);
            state[0] = 1;
            ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,function itemHandle2(param1:ItemEvent):void
            {
               var evt:ItemEvent = param1;
               ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,itemHandle2);
               if(ItemManager.getSpecialItem(ITEM) == null)
               {
                  state[2] = 0;
               }
               else
               {
                  state[2] = ItemManager.getSpecialItem(ITEM).quantity;
               }
               ServerBufferManager.getServerBuffer(ServerBufferType.RABIT_FIRST,function(param1:ServerBuffer):void
               {
                  var _scenMc:MovieClip = null;
                  var server:ServerBuffer = param1;
                  var _isPlay:Boolean = Boolean(server.readDataAtPostion(1));
                  if(!_isPlay)
                  {
                     _scenMc = getMovie("sceneTalk_1");
                     _mapModel.front.addChild(_scenMc);
                     MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
                     {
                        DisplayUtil.removeForParent(_scenMc);
                        _scenMc = null;
                        ServerBufferManager.updateServerBuffer(ServerBufferType.RABIT_FIRST,1,1);
                        state[0] = 1;
                        if(state[1] == 0)
                        {
                           state[1] = 386;
                        }
                        MorphManager.startThisMorph(state[1]);
                     },true);
                  }
                  else
                  {
                     if(state[1] == 0)
                     {
                        state[1] = 386;
                     }
                     MorphManager.startThisMorph(state[1]);
                  }
               },true);
            });
            ItemManager.requestSpecialItemList(false);
         }
         else
         {
            MorphManager.startThisMorph(state[1]);
         }
      }
      
      private function addMonster() : void
      {
         var _loc2_:SpawnedPet = null;
         var _loc1_:uint = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = new SpawnedPet(170,this.POS_INDEX,0);
            MobileManager.addMobile(_loc2_,MobileType.SPAWNED_PET);
            _loc1_++;
         }
      }
      
      private function addMonsterClick() : void
      {
         var _loc2_:Mobile = null;
         var _loc1_:Vector.<Mobile> = MobileManager.getMobileVec(MobileType.SPAWNED_PET);
         for each(_loc2_ in _loc1_)
         {
            _loc2_.addEventListener(MouseEvent.CLICK,this.onMonsterClick);
         }
      }
      
      private function onMonsterClick(param1:MouseEvent) : void
      {
         if((PetInfoManager.getFirstPetInfo() as PetInfo).resourceId != 386)
         {
            ActorManager.getActor().stand();
            AlertManager.showAlert("首发精灵是薄暮兔才可以挑战哦");
         }
      }
      
      private function removeMonsterClick() : void
      {
         var _loc2_:Mobile = null;
         var _loc1_:Vector.<Mobile> = MobileManager.getMobileVec(MobileType.SPAWNED_PET);
         for each(_loc2_ in _loc1_)
         {
            _loc2_.removeEventListener(MouseEvent.CLICK,this.onMonsterClick);
         }
      }
      
      private function addNpc() : void
      {
         this.removeNpc();
         this._npc = this.getMovie("npc");
         this._npc.x = this.NPC_POS[0];
         this._npc.y = this.NPC_POS[1];
         this._npc.scaleX = -1;
         this._npc.buttonMode = true;
         this._mapModel.content.addChild(this._npc);
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
      }
      
      private function removeNpc() : void
      {
         if(this._npc)
         {
            DisplayUtil.removeForParent(this._npc);
         }
         this._npc = null;
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(state[3] == 1)
         {
            NpcDialog.show(574,"暗夜兔",[[0,"哈哈哈，你已经获得暗夜之芯啦!"]],["你太丑了，我不变"],[null]);
         }
         else
         {
            NpcDialog.show(574,"暗夜兔",[[0,"喂喂喂，想变身吗？来找我吧，让你全身充满暗月之能。你目前有暗月能<font color=\'#ff3300\'>" + state[2] + "</font>个。"]],["薄暮兔变身","你太丑了，我不变"],[function():void
            {
               askDress();
            },null]);
         }
      }
      
      private function askDress() : void
      {
         if(state[2] >= 25)
         {
            SwapManager.swapItem(this.SWAP_ID,1,function(param1:IDataInput):void
            {
               new SwapInfo(param1);
               state[3] = 1;
               dressTwoHandle();
            });
         }
         else
         {
            AlertManager.showAlert("你还没有25个暗月能哟，快去打小恶魔收集吧。");
         }
      }
      
      private function afterFight() : void
      {
         ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.getItemHandle1);
         ItemManager.requestSpecialItemList(true);
      }
      
      private function getItemHandle1(param1:ItemEvent) : void
      {
         var tpNum:int = 0;
         var mc:MovieClip = null;
         var evt:ItemEvent = param1;
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.getItemHandle1);
         if(ItemManager.getSpecialItem(this.ITEM) == null)
         {
            tpNum = 0;
         }
         else
         {
            tpNum = int(ItemManager.getSpecialItem(this.ITEM).quantity);
         }
         if(tpNum > state[2])
         {
            state[2] = tpNum;
            if(25 - state[2] > 0)
            {
               ServerMessager.addMessage("你还需要收集" + (25 - state[2]) + "个暗月能。");
            }
            if(25 - state[2] == 0)
            {
               ServerMessager.addMessage("你已收集完毕，快去兑换暗夜兔吧");
            }
            mc = this.getMovie("mc1");
            mc.x = ActorManager.getActor().x + ActorManager.getActor().width / 2;
            mc.y = ActorManager.getActor().y + ActorManager.getActor().height;
            this._mapModel.front.addChild(mc);
            MovieClipUtil.playMc(mc,2,mc.totalFrames,function():void
            {
               DisplayUtil.removeForParent(mc);
               mc = null;
            });
         }
      }
      
      private function test() : void
      {
         var mc:MovieClip = null;
         mc = this.getMovie("mc1");
         mc.x = ActorManager.getActor().x;
         mc.y = ActorManager.getActor().y;
         this._mapModel.front.addChild(mc);
         MovieClipUtil.playMc(mc,2,mc.totalFrames,function():void
         {
            DisplayUtil.removeForParent(mc);
            mc = null;
         });
      }
      
      private function test1() : void
      {
         var mc:MovieClip = null;
         state[1] = 388;
         MorphManager.startThisMorph(state[1]);
         mc = this.getMovie("mc2");
         mc.x = ActorManager.getActor().x + ActorManager.getActor().width / 2;
         mc.y = ActorManager.getActor().y + ActorManager.getActor().height / 2;
         this._mapModel.front.addChild(mc);
         MovieClipUtil.playMc(mc,2,mc.totalFrames,function():void
         {
            DisplayUtil.removeForParent(mc);
            mc = null;
         });
      }
      
      private function dressTwoHandle() : void
      {
         var mc:MovieClip = null;
         ActorManager.getActor().stand();
         state[1] = 388;
         MorphManager.startThisMorph(state[1]);
         mc = this.getMovie("mc2");
         mc.x = ActorManager.getActor().x + ActorManager.getActor().width / 2;
         mc.y = ActorManager.getActor().y + ActorManager.getActor().height / 2;
         this._mapModel.front.addChild(mc);
         MovieClipUtil.playMc(mc,2,mc.totalFrames,function():void
         {
            DisplayUtil.removeForParent(mc);
            mc = null;
         });
      }
      
      private function onSwitch(param1:SceneEvent) : void
      {
         this._mapModel = SceneManager.active.mapModel;
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT)
         {
            this.afterFight();
         }
         if(SceneManager.prevMapID == 80020 && SceneManager.active.type != SceneType.ARENA)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitch);
            MorphManager.removeMorph(ActorManager.getActor());
            RabitDressAct.state = [0,0,0,0];
            this.dispose();
         }
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
         this.removeNpc();
      }
   }
}
