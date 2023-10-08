package com.taomee.seer2.app.home.nextyearActivity
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.home.HomeScene;
   import com.taomee.seer2.app.home.data.NextyearActivityInfo;
   import com.taomee.seer2.app.manager.InteractiveRewardManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1060;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   import org.taomee.ds.HashMap;
   
   public class NextyearActivityHome
   {
       
      
      private var _nextCount:int;
      
      private var _info:NextyearActivityInfo;
      
      private var _resLib:ResourceLibrary;
      
      private var _nextyear:MovieClip;
      
      private var _getGiftPanel:MovieClip;
      
      private var _getGiftVec:Vector.<MovieClip>;
      
      private var _senderMap:HashMap;
      
      public function NextyearActivityHome(param1:NextyearActivityInfo, param2:ResourceLibrary)
      {
         super();
         this._info = param1;
         this._resLib = param2;
         this.createChildren();
      }
      
      private function createChildren() : void
      {
         this.init();
         if((SceneManager.active as HomeScene).mapID == ActorManager.actorInfo.id)
         {
            this.initGetGift();
            this.processSelfHome();
         }
         this.updateStatus();
      }
      
      private function processSelfHome() : void
      {
         TooltipManager.remove(this._nextyear);
         this._nextyear.removeEventListener(MouseEvent.CLICK,this.onSelfClick);
         if(this._info.isYes == 1)
         {
            TooltipManager.addCommonTip(this._nextyear,"领取春节红包");
            this._nextyear.addEventListener(MouseEvent.CLICK,this.onSelfClick);
         }
         else
         {
            TooltipManager.addCommonTip(this._nextyear,"您的红包是空的");
         }
      }
      
      private function onSelfClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         for each(_loc2_ in this._getGiftVec)
         {
            _loc2_.visible = false;
         }
         Connection.addErrorHandler(CommandSet.GET_HOME_FIGHT_COUNT_1191,this.onGetGiftListError);
         Connection.addCommandListener(CommandSet.GET_HOME_FIGHT_COUNT_1191,this.onGetGiftList);
         Connection.send(CommandSet.GET_HOME_FIGHT_COUNT_1191);
         LayerManager.topLayer.addChild(this._getGiftPanel);
      }
      
      private function onGetGiftListError(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.GET_HOME_FIGHT_COUNT_1191,this.onGetGiftListError);
         Connection.removeCommandListener(CommandSet.GET_HOME_FIGHT_COUNT_1191,this.onGetGiftList);
         AlertManager.showAlert("拉取礼物列表失败，请关闭面板后重试");
      }
      
      private function onGetGiftList(param1:MessageEvent) : void
      {
         var _loc4_:Vector.<uint> = null;
         Connection.removeErrorHandler(CommandSet.GET_HOME_FIGHT_COUNT_1191,this.onGetGiftListError);
         Connection.removeCommandListener(CommandSet.GET_HOME_FIGHT_COUNT_1191,this.onGetGiftList);
         this._senderMap = new HashMap();
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedByte());
         _loc4_ = Vector.<uint>([]);
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_.push(1);
            _loc5_++;
         }
         var _loc6_:uint = uint(_loc2_.readUnsignedByte());
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc4_.push(2);
            _loc7_++;
         }
         this._nextCount = _loc3_ + _loc6_;
         var _loc8_:int = 0;
         while(_loc8_ < _loc4_.length)
         {
            this._getGiftVec[_loc8_].visible = true;
            this._getGiftVec[_loc8_].buttonMode = true;
            this._getGiftVec[_loc8_].gotoAndStop(_loc4_[_loc8_]);
            this._getGiftVec[_loc8_].addEventListener(MouseEvent.CLICK,this.onMouse);
            _loc8_++;
         }
      }
      
      private function onMouse(param1:MouseEvent) : void
      {
         var mc:MovieClip = null;
         var event:MouseEvent = param1;
         mc = event.currentTarget as MovieClip;
         if(mc.currentFrame == 1)
         {
            SwapManager.swapItem(217,1,function(param1:IDataInput):void
            {
               var _loc2_:SwapInfo = new SwapInfo(param1);
               mc.visible = false;
               --_nextCount;
               if(_nextCount <= 0)
               {
                  onGetPanelClose(null);
               }
            });
         }
         else
         {
            InteractiveRewardManager.requestReward(66,function(param1:Parser_1060):void
            {
               param1.showResult();
               mc.visible = false;
               --_nextCount;
               if(_nextCount <= 0)
               {
                  onGetPanelClose(null);
               }
            });
         }
      }
      
      private function init() : void
      {
         this._nextyear = this._resLib.getMovieClip("mouseMC");
         if(this._nextyear == null)
         {
            return;
         }
         this._nextyear.buttonMode = true;
         this._nextyear.x = 275;
         this._nextyear.y = 150;
         this._nextyear.gotoAndStop(1);
         SceneManager.active.mapModel.content.addChild(this._nextyear);
      }
      
      private function initGetGift() : void
      {
         this._getGiftPanel = this._resLib.getMovieClip("mousePanel");
         if(this._getGiftPanel == null)
         {
            return;
         }
         this._getGiftPanel.x = 300;
         this._getGiftPanel.y = 70;
         this._getGiftPanel["closeBtn"].addEventListener(MouseEvent.CLICK,this.onGetPanelClose);
         this._getGiftVec = new Vector.<MovieClip>();
         var _loc1_:uint = 0;
         while(_loc1_ < 10)
         {
            this._getGiftVec.push(this._getGiftPanel["next" + _loc1_]);
            _loc1_++;
         }
      }
      
      private function onGetPanelClose(param1:MouseEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.GET_HOME_FIGHT_COUNT_1191,this.onGetGiftListError);
         Connection.removeCommandListener(CommandSet.GET_HOME_FIGHT_COUNT_1191,this.onGetGiftList);
         DisplayObjectUtil.removeFromParent(this._getGiftPanel);
         if(this._nextCount <= 0)
         {
            TooltipManager.addCommonTip(this._nextyear,"您的红包是空的");
            this._nextyear.gotoAndStop(1);
            this._nextyear.removeEventListener(MouseEvent.CLICK,this.onSelfClick);
         }
      }
      
      private function updateStatus() : void
      {
         if(this._nextyear == null)
         {
            return;
         }
         if(this._info.isYes == 0)
         {
            this._nextyear.gotoAndStop(1);
         }
         else
         {
            this._nextyear.gotoAndStop(2);
         }
         if((SceneManager.active as HomeScene).mapID != ActorManager.actorInfo.id)
         {
            this._nextyear.buttonMode = false;
            this._nextyear.gotoAndStop(1);
         }
      }
      
      public function dispose() : void
      {
         Connection.removeErrorHandler(CommandSet.GET_HOME_FIGHT_COUNT_1191,this.onGetGiftListError);
         Connection.removeCommandListener(CommandSet.GET_HOME_FIGHT_COUNT_1191,this.onGetGiftList);
      }
   }
}
