package com.taomee.seer2.app.processor.activity.planet
{
   import com.taomee.seer2.app.component.IconDisplayer;
   import com.taomee.seer2.app.config.PlanetConfig;
   import com.taomee.seer2.app.config.info.PlanetInfo;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.inventory.item.SpecialItem;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class PlanetManager
   {
      
      public static var iconId:uint;
      
      private static var _iconVec:Vector.<IconDisplayer>;
      
      private static var _idVec:Vector.<uint>;
      
      private static var _info:PlanetInfo;
       
      
      public function PlanetManager()
      {
         super();
      }
      
      public static function setup() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
         SceneManager.addEventListener(SceneEvent.SWITCH_START,onStart);
      }
      
      private static function onComplete(param1:SceneEvent) : void
      {
         _info = PlanetConfig.getInfo(SceneManager.active.mapID);
         if(_info != null)
         {
            ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,onSeer);
            ItemManager.requestSpecialItemList();
         }
      }
      
      private static function onSeer(param1:ItemEvent) : void
      {
         var _loc2_:IconDisplayer = null;
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,onSeer);
         if(_info.mapId == 230)
         {
            _info.idList = [501003];
            _info.swapList = [717];
            _info.tipList = ["它藏着的地方站着母子二人"];
         }
         updateInfo();
         _iconVec = Vector.<IconDisplayer>([]);
         var _loc3_:int = 0;
         while(_loc3_ < _info.idList.length)
         {
            _loc2_ = new IconDisplayer();
            _loc2_.addEventListener(MouseEvent.ROLL_OVER,onOver);
            _loc2_.addEventListener(MouseEvent.ROLL_OUT,onOut);
            _loc2_.addEventListener(MouseEvent.CLICK,onIcon);
            LayerManager.mapLayer.addChild(_loc2_);
            _loc2_.setIconUrl(URLUtil.getActivityAnimation("planet/item/" + _info.idList[_loc3_]));
            _iconVec.push(_loc2_);
            _loc3_++;
         }
      }
      
      private static function onOver(param1:MouseEvent) : void
      {
         var _loc2_:IconDisplayer = param1.currentTarget as IconDisplayer;
         var _loc3_:GlowFilter = new GlowFilter();
         _loc3_.blurX = 20;
         _loc3_.blurY = 20;
         _loc3_.color = 16777215;
         _loc3_.inner = false;
         _loc2_.filters = [_loc3_];
      }
      
      private static function onOut(param1:MouseEvent) : void
      {
         var _loc2_:IconDisplayer = param1.currentTarget as IconDisplayer;
         _loc2_.filters = [];
      }
      
      private static function updateInfo() : void
      {
         var _loc4_:SpecialItem = null;
         var _loc1_:Array = [];
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < _info.idList.length)
         {
            if(!(_loc4_ = ItemManager.getSpecialItem(_info.idList[_loc3_])))
            {
               _loc1_.push(_info.idList[_loc3_]);
               _loc2_.push(_info.swapList[_loc3_]);
            }
            _loc3_++;
         }
         _info.idList = _loc1_;
         _info.swapList = _loc2_;
      }
      
      private static function onIcon(param1:MouseEvent) : void
      {
         var icon:IconDisplayer = null;
         var index:int = 0;
         var event:MouseEvent = param1;
         icon = event.currentTarget as IconDisplayer;
         index = _iconVec.indexOf(icon);
         SwapManager.swapItem(_info.swapList[index],1,function(param1:IDataInput):void
         {
            var data:IDataInput = param1;
            new SwapInfo(data,false);
            PlanetManager.iconId = _info.idList[index];
            DisplayUtil.removeForParent(icon);
            MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("planet/animation/" + _info.idList[index]),function():void
            {
               QueueLoader.load(URLUtil.getActivityAnimation("planet/title"),LoadType.SWF,onResLoaded);
            },true,false,2);
         });
         if(_info.idList[0] == 501005)
         {
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_109);
         }
         if(_info.idList[0] == 501006)
         {
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_301);
         }
         if(_info.idList[0] == 501007)
         {
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_490);
         }
      }
      
      private static function onResLoaded(param1:ContentInfo) : void
      {
         var item:MovieClip = null;
         var info:ContentInfo = param1;
         var mc:MovieClip = info.content as MovieClip;
         item = mc["item"];
         LayerManager.topLayer.addChild(item);
         MovieClipUtil.playMc(item,2,item.totalFrames,function():void
         {
            DisplayUtil.removeForParent(item);
            ModuleManager.toggleModule(URLUtil.getAppModule("PlanetPanel"),"正在打开...");
         },true);
      }
      
      private static function onStart(param1:SceneEvent) : void
      {
         var _loc2_:IconDisplayer = null;
         _info = null;
         for each(_loc2_ in _iconVec)
         {
            DisplayUtil.removeForParent(_loc2_);
         }
      }
   }
}
