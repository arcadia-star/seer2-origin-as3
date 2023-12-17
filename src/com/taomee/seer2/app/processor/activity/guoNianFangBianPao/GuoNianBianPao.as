package com.taomee.seer2.app.processor.activity.guoNianFangBianPao
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.popup.AlertManager;
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
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class GuoNianBianPao
   {
      
      private static const bian_pao_id:int = 353;
      
      private static const position_array:Array = [new Point(605,484),new Point(250,423),new Point(263,414),new Point(488,470),new Point(523,442),new Point(534,413),new Point(530,476)];
      
      private static const map_id_array:Array = [10,90,160,230,470,320,540];
      
      private static const day_limit_id:int = 982;
      
      private static const swap_id:int = 2386;
      
      private static var resLib:ResourceLibrary;
      
      private static var loadOver:Boolean;
       
      
      private var localMap:MapModel;
      
      private var bianPaoNpc:Mobile;
      
      private var chanceUsedCount:int;
      
      private var bianPaoMv:MovieClip;
      
      public function GuoNianBianPao(param1:MapModel)
      {
         super();
         this.localMap = param1;
      }
      
      public function initBianPao() : void
      {
         this.initResource();
         this.bianPaoNpc = new Mobile();
         this.bianPaoNpc.resourceUrl = URLUtil.getNpcSwf(bian_pao_id);
         this.bianPaoNpc.buttonMode = true;
         this.bianPaoNpc.setPostion(position_array[map_id_array.indexOf(this.localMap.id)]);
         MobileManager.addMobile(this.bianPaoNpc,MobileType.NPC);
         this.bianPaoNpc.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(loadOver == false)
         {
            return;
         }
         DayLimitManager.getDoCount(day_limit_id,function(param1:uint):void
         {
            var count:uint = param1;
            chanceUsedCount = count;
            if(chanceUsedCount >= 1)
            {
               AlertManager.showAlert("燃放过多爆竹会污染环境~请明天再来放吧~");
               return;
            }
            NpcDialog.show(bian_pao_id,"爆竹",[[0,"祝小赛尔们新年快乐，点燃我获得珍贵道具哦!"]],["点燃爆竹","保护环境，待会再点"],[function():void
            {
               SwapManager.swapItem(swap_id,1,function(param1:IDataInput):void
               {
                  var data:IDataInput = param1;
                  bianPaoMv = resLib.getMovieClip("bianPaoMv");
                  LayerManager.topLayer.addChild(bianPaoMv);
                  bianPaoMv.x = bianPaoNpc.x;
                  bianPaoMv.y = bianPaoNpc.y;
                  bianPaoNpc.visible = false;
                  MovieClipUtil.playMc(bianPaoMv,1,bianPaoMv.totalFrames,function():void
                  {
                     DisplayObjectUtil.removeFromParent(bianPaoMv);
                     bianPaoMv.stop();
                     bianPaoMv = null;
                     bianPaoNpc.visible = true;
                     new SwapInfo(data);
                     chanceUsedCount += 1;
                  });
               });
            }]);
         });
      }
      
      public function dispose() : void
      {
         if(this.bianPaoNpc)
         {
            DisplayObjectUtil.removeFromParent(this.bianPaoNpc);
            this.bianPaoNpc.removeEventListener(MouseEvent.CLICK,this.onClick);
            this.bianPaoNpc = null;
         }
         if(this.bianPaoMv)
         {
            DisplayObjectUtil.removeFromParent(this.bianPaoMv);
            this.bianPaoMv.stop();
            this.bianPaoMv = null;
         }
      }
      
      private function initResource() : void
      {
         if(resLib == null)
         {
            QueueLoader.load(URLUtil.getActivityAnimation("GuoNianBianPaoRes"),LoadType.DOMAIN,this.onLoadOver);
         }
      }
      
      private function onLoadOver(param1:ContentInfo) : void
      {
         resLib = new ResourceLibrary(param1.content);
         loadOver = true;
      }
   }
}
