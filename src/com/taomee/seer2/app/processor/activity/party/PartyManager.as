package com.taomee.seer2.app.processor.activity.party
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.guide.info.GudieDirectionType;
   import com.taomee.seer2.app.guide.manager.GuideManager;
   import com.taomee.seer2.app.morphSystem.MorphUpdate;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class PartyManager
   {
       
      
      private var _resLib:ResourceLibrary;
      
      private var _animation:MovieClip;
      
      private var _morph:Mobile;
      
      private var _npcList:Vector.<Mobile>;
      
      private var _one:Boolean;
      
      public function PartyManager()
      {
         super();
      }
      
      public function setup() : void
      {
         this.loadRes();
         this.initNpc();
         this.addNpcEvent();
         this.updateMorphTip();
      }
      
      private function initNpc() : void
      {
         this._morph = MobileManager.getMobile(189,MobileType.NPC);
         this._npcList = Vector.<Mobile>([]);
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this._npcList.push(MobileManager.getMobile(537 + _loc1_,MobileType.NPC));
            _loc1_++;
         }
      }
      
      private function addNpcEvent() : void
      {
         var _loc1_:Mobile = null;
         this._morph.buttonMode = true;
         this._morph.addEventListener(MouseEvent.CLICK,this.onMorph);
         for each(_loc1_ in this._npcList)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onNpc,false,1);
         }
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.showNpcChallengePanel);
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         if(this._resLib == null)
         {
            param1.stopImmediatePropagation();
            return;
         }
         if(ActorManager.actorInfo.morphInfo.morphId != 351)
         {
            param1.stopImmediatePropagation();
            this._one = true;
            this.playAnimation();
         }
      }
      
      private function showNpcChallengePanel(param1:DialogPanelEvent) : void
      {
         if(Boolean(DateUtil.inInDateScope(6,14,0,16)) || Boolean(DateUtil.inInDateScope(0,14,0,16)))
         {
            if((param1.content as DialogPanelEventData).params == "fight0")
            {
               FightManager.startFightWithNPC(42);
            }
            if((param1.content as DialogPanelEventData).params == "fight1")
            {
               FightManager.startFightWithNPC(43);
            }
            if((param1.content as DialogPanelEventData).params == "fight2")
            {
               FightManager.startFightWithNPC(44);
            }
         }
         else
         {
            if((param1.content as DialogPanelEventData).params == "fight0")
            {
               NpcDialog.show(537,"暗笑葵",[[0,"只有在2013年5月18日-5月19日的14:00-16:00才能挑战我哦"]],["我知道啦"]);
            }
            if((param1.content as DialogPanelEventData).params == "fight1")
            {
               NpcDialog.show(538,"残酷钳",[[0,"只有在2013年5月18日-5月19日的14:00-16:00才能挑战我哦"]],["我知道啦"]);
            }
            if((param1.content as DialogPanelEventData).params == "fight2")
            {
               NpcDialog.show(539,"绝望肤",[[0,"只有在2013年5月18日-5月19日的14:00-16:00才能挑战我哦"]],["我知道啦"]);
            }
         }
      }
      
      private function closeOrOpenNpcMouse(param1:Boolean) : void
      {
         var _loc2_:Mobile = null;
         for each(_loc2_ in this._npcList)
         {
            _loc2_.mouseChildren = param1;
            _loc2_.mouseEnabled = param1;
         }
      }
      
      private function onMorph(param1:MouseEvent) : void
      {
         var swapId:uint = 0;
         var event:MouseEvent = param1;
         if(this._one)
         {
            GuideManager.instance.pause();
            SwapManager.swapItem(926,1,function(param1:IDataInput):void
            {
               var data:IDataInput = param1;
               MorphUpdate.updateMorph(function():void
               {
                  updateMorphTip();
               });
               _animation = _resLib.getMovieClip("animation1");
               LayerManager.topLayer.addChild(_animation);
               MovieClipUtil.playMc(_animation,2,_animation.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(_animation);
                  _one = false;
                  ServerBufferManager.updateServerBuffer(ServerBufferType.PARTY_ACTIVITY,0,1);
               },true);
            });
         }
         else
         {
            if(ActorManager.actorInfo.morphInfo.morphId == 0)
            {
               swapId = 926;
            }
            else
            {
               swapId = 927;
            }
            SwapManager.swapItem(swapId,1,function(param1:IDataInput):void
            {
               var data:IDataInput = param1;
               MorphUpdate.updateMorph(function():void
               {
                  updateMorphTip();
               });
            });
         }
      }
      
      private function updateMorphTip() : void
      {
         if(ActorManager.actorInfo.morphInfo.morphId == 0)
         {
            TooltipManager.addCommonTip(this._morph,"开始变身");
         }
         else
         {
            TooltipManager.addCommonTip(this._morph,"解除变身");
         }
      }
      
      private function initAnimation() : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.PARTY_ACTIVITY,function(param1:ServerBuffer):void
         {
            if(param1.readDataAtPostion(0) == 0)
            {
               _one = true;
               playAnimation();
            }
         });
      }
      
      private function playAnimation() : void
      {
         this._animation = this._resLib.getMovieClip("animation0");
         LayerManager.topLayer.addChild(this._animation);
         MovieClipUtil.playMc(this._animation,2,this._animation.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_animation);
            var _loc1_:Rectangle = new Rectangle(0,0,85,95);
            GuideManager.instance.addTarget(_loc1_,0);
            GuideManager.instance.addGuide2Target(_loc1_,0,0,new Point(769,273),false,false,GudieDirectionType.CONTENT);
            GuideManager.instance.startGuide(0);
         },true);
      }
      
      private function loadRes() : void
      {
         if(!this._resLib)
         {
            this.closeOrOpenNpcMouse(false);
            QueueLoader.load(URLUtil.getActivityAnimation("partyActivity/partyActivity"),LoadType.DOMAIN,this.onLoadComplete);
         }
      }
      
      private function onLoadComplete(param1:ContentInfo) : void
      {
         this._resLib = new ResourceLibrary(param1.content);
         this.closeOrOpenNpcMouse(true);
         this.initAnimation();
      }
      
      public function dispose() : void
      {
         var _loc1_:Mobile = null;
         this._morph.removeEventListener(MouseEvent.CLICK,this.onMorph);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.showNpcChallengePanel);
         for each(_loc1_ in this._npcList)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onNpc);
         }
         if(this._resLib)
         {
            this._resLib.dispose();
            this._resLib = null;
         }
      }
   }
}
