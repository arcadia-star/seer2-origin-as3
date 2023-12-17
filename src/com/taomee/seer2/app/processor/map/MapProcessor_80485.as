package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class MapProcessor_80485 extends MapProcessor
   {
       
      
      private const FOR_LIST:Array = [250471];
      
      private const DAY_LIST:Array = [5204,5206,5203];
      
      private const SWAP_LIST:Array = [4221];
      
      private var _boss:Mobile;
      
      public function MapProcessor_80485(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         if(DateUtil.isInTime(new Date(2015,8,18,0,0,0),new Date(2015,8,25,23,59,59)))
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.RabbitMoonLightCapsule,function(param1:ServerBuffer):void
            {
               var server:ServerBuffer = param1;
               var _isPlay:Boolean = Boolean(server.readDataAtPostion(1));
               if(!_isPlay)
               {
                  ServerBufferManager.updateServerBuffer(ServerBufferType.RabbitMoonLightCapsule,1,1);
                  MovieClipUtil.getSwfContent(URLUtil.getActivityAnimation("RabbitMoonLightCapsule/sceneAnimation"),function callBack(param1:MovieClip):void
                  {
                     var tempNpc:Mobile = null;
                     var movie:MovieClip = null;
                     var mc:MovieClip = param1;
                     ActorManager.getActor().hide();
                     tempNpc = MobileManager.getMobile(3032,MobileType.NPC);
                     if(tempNpc != null)
                     {
                        tempNpc.visible = false;
                     }
                     movie = mc["test"];
                     _map.front.addChild(movie);
                     MovieClipUtil.playMc(movie,2,movie.totalFrames,function callBack():void
                     {
                        movie.gotoAndStop(1);
                        DisplayObjectUtil.removeFromParent(movie);
                        movie = null;
                        addNpc(3036,new Point(597,459));
                        if(tempNpc != null)
                        {
                           tempNpc.visible = true;
                        }
                        ActorManager.getActor().show();
                     });
                  });
               }
               else
               {
                  addNpc(3036,new Point(597,459));
               }
            });
         }
      }
      
      private function addNpc(param1:int, param2:Point) : void
      {
         this._boss = new Mobile();
         this._boss.resourceUrl = URLUtil.getNpcSwf(param1);
         this._boss.x = param2.x;
         this._boss.y = param2.y;
         this._boss.buttonMode = true;
         this._boss.scaleX = 1;
         this.showMouseHintAtMonster(this._boss);
         MobileManager.addMobile(this._boss,MobileType.NPC);
         this._boss.addEventListener(MouseEvent.CLICK,this.onBossClick);
      }
      
      private function removeNpc() : void
      {
         if(this._boss)
         {
            DisplayObjectUtil.removeFromParent(this._boss);
            this._boss.removeEventListener(MouseEvent.CLICK,this.onBossClick);
            this._boss = null;
         }
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         SwapManager.swapItem(this.SWAP_LIST[0],1,function success(param1:IDataInput):void
         {
            var data:IDataInput = param1;
            new SwapInfo(data);
            ActiveCountManager.requestActiveCountList(FOR_LIST,function callBack(param1:Parser_1142):void
            {
               var par:Parser_1142 = param1;
               DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
               {
                  var info:DayLimitListInfo = param1;
                  var cdTime:int = info.getCount(DAY_LIST[1]) - TimeManager.getServerTime();
                  var transTimes:int = 5 + par.infoVec[0] - info.getCount(DAY_LIST[2]);
                  if(info.getCount(DAY_LIST[0]) == 0 && cdTime <= 0)
                  {
                     if(transTimes <= 0)
                     {
                        ShopManager.buyItemForId(606549,function(param1:*):void
                        {
                           ModuleManager.showAppModule("RabbitTransformSuccessPanel");
                        });
                     }
                     else
                     {
                        ModuleManager.showAppModule("RabbitTransformSuccessPanel");
                     }
                  }
                  else
                  {
                     AlertManager.showAlert("还不能变身，要稍等一会儿呦。");
                  }
               });
            });
         });
      }
      
      private function showMouseHintAtMonster(param1:Mobile) : void
      {
         var _loc2_:MouseClickHintSprite = new MouseClickHintSprite();
         _loc2_.y = -_loc2_.height - 20;
         _loc2_.x = (param1.width - param1.width) / 2;
         param1.addChild(_loc2_);
      }
      
      override public function dispose() : void
      {
         this.removeNpc();
         super.dispose();
      }
   }
}
