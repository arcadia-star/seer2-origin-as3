package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class MapProcessor_80344 extends MapProcessor
   {
       
      
      private var _npc:Mobile;
      
      private var _res:MovieClip;
      
      private var _cartoon:MovieClip;
      
      private const SWAP_TASK:uint = 3451;
      
      public function MapProcessor_80344(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         ActorManager.getActor().hide();
         ActorManager.getActor().blockNoNo = true;
         QueueLoader.load(URLUtil.getActivityAnimation("cindysMemory/Cindy1"),LoadType.SWF,this.onLoad);
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(576,445));
            this._npc.resourceUrl = URLUtil.getNpcSwf(1);
            this._npc.buttonMode = true;
            this._npc.gotoAndStop(2);
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.initDialog);
         }
         ActorManager.getActor().show();
         ActorManager.getActor().blockNoNo = false;
      }
      
      private function initDialog(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(400,"小赛尔",[[0,"吓了我一跳"]],["船长，刚才那个精灵是谁？"],[function():void
         {
            NpcDialog.show(1,"船长",[[0,"它是雷霆，是我的精灵。"]],["船长的精灵？"],[function():void
            {
               MovieClipUtil.getSwfContent(URLUtil.getActivityAnimation("cindysMemory/CindysAnime"),function(param1:MovieClip):void
               {
                  var mc:MovieClip = param1;
                  _cartoon = mc;
                  _cartoon.x = 0;
                  _cartoon.y = 0;
                  LayerManager.topLayer.addChild(_cartoon);
                  NpcDialog.show(400,"小赛尔",[[0,"不过我确实困惑了好久：船长的精灵去哪了？\n竟然一直在飞船上？！"]],["它为什么要逃走？"],[function():void
                  {
                     NpcDialog.show(1,"船长",[[0,"现在雷霆很虚弱，而且它不喜欢陌生人。"]],["我还想知道更多！"],[function():void
                     {
                        DisplayObjectUtil.removeFromParent(_cartoon);
                        SwapManager.swapItem(SWAP_TASK,1,function(param1:IDataInput):void
                        {
                           var data:IDataInput = param1;
                           new SwapInfo(data);
                           SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,function switchOver():void
                           {
                              SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,switchOver);
                              ModuleManager.showAppModule("CindysMemoryPanel");
                           });
                           ActsHelperUtil.goHandle(70);
                        });
                     }]);
                  }]);
               });
            }]);
         }]);
      }
      
      private function onLoad(param1:ContentInfo) : void
      {
         var info:ContentInfo = param1;
         this._res = info.content;
         this._res.x = 0;
         this._res.y = 0;
         _map.content.addChild(this._res);
         MovieClipUtil.playMc(this._res,20,this._res.totalFrames,function():void
         {
            _map.content.removeChild(_res);
            createNpc();
         });
      }
   }
}
