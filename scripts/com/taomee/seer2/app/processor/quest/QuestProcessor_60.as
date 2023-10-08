package com.taomee.seer2.app.processor.quest
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.guide.info.GudieDirectionType;
   import com.taomee.seer2.app.guide.manager.GuideManager;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.plant.event.PlantEvent;
   import com.taomee.seer2.app.plant.event.PlantEventControl;
   import com.taomee.seer2.app.plant.panelControl.PlantPanelControl;
   import com.taomee.seer2.app.plantSystem.PlantManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.Quest;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import org.taomee.filter.ColorFilter;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestProcessor_60 extends QuestProcessor
   {
       
      
      private var _playMC:MovieClip;
      
      public function QuestProcessor_60(param1:Quest)
      {
         super(param1);
         SceneManager.addEventListener(SceneEvent.SWITCH_START,this.onMapStart);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
      }
      
      private function onMapComplete(param1:SceneEvent) : void
      {
         if(SceneManager.active.mapID == ActorManager.actorInfo.id && SceneManager.active.type == SceneType.PLANT)
         {
            if(QuestManager.isAccepted(60) || QuestManager.isCanAccepted(60))
            {
               QueueLoader.load(URLUtil.getQuestAnimation("sceneAnimation/" + _quest.id),LoadType.DOMAIN,this.loadComplete);
            }
         }
      }
      
      private function onMapStart(param1:SceneEvent) : void
      {
         hideMouseClickHint();
         PlantEventControl.removeEventListener(PlantEvent.SEED_STATUS_CHANGE,this.onSeedStatusChange);
      }
      
      private function loadComplete(param1:ContentInfo) : void
      {
         _isLoadResLib = false;
         _mapModel = SceneManager.active.mapModel;
         _resLib = new ResourceLibrary(param1.content);
         ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.onGetItem);
         ItemManager.requestSpecialItemList();
      }
      
      private function onGetItem(param1:ItemEvent) : void
      {
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.onGetItem);
         this.nextProcessor();
      }
      
      private function nextProcessor() : void
      {
         if(QuestManager.isCanAccepted(_quest.id))
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
            QuestManager.accept(_quest.id);
         }
         else if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.next1();
         }
         else if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.next2();
         }
         else if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.next3();
         }
         else if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.next4();
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         this.next1();
      }
      
      private function next1() : void
      {
         PlantPanelControl.getSidBar().warehouse.mouseEnabled = false;
         ColorFilter.setGrayscale(PlantPanelControl.getSidBar().warehouse);
         showMouseHintAt(170,290);
         SceneManager.active.mapModel.content["land0"].addEventListener(MouseEvent.CLICK,this.onLand,false,1);
      }
      
      private function onLand(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         event.stopImmediatePropagation();
         PlantPanelControl.getSidBar().warehouse.mouseEnabled = true;
         PlantPanelControl.getSidBar().warehouse.filters = [];
         hideMouseClickHint();
         SceneManager.active.mapModel.content["land0"].removeEventListener(MouseEvent.CLICK,this.onLand);
         this._playMC = _resLib.getMovieClip("landAnimation");
         LayerManager.topLayer.addChild(this._playMC);
         PlantManager.isQuest = true;
         MovieClipUtil.playMc(this._playMC,2,this._playMC.totalFrames,function():void
         {
            PlantManager.isQuest = false;
            DisplayUtil.removeForParent(_playMC);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
            QuestManager.completeStep(_quest.id,1);
         },true);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         var _loc2_:Teleport = null;
         var _loc3_:Teleport = null;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         if(param1.stepId == 1)
         {
            this.next2();
         }
         else if(param1.stepId == 2)
         {
            this.next3();
         }
         else if(param1.stepId == 3)
         {
            this.next4();
         }
         else if(param1.stepId == 4)
         {
            _loc2_ = AnimateElementManager.getElement(1) as Teleport;
            _loc2_.visible = true;
            _loc3_ = AnimateElementManager.getElement(2) as Teleport;
            _loc3_.visible = true;
         }
      }
      
      private function next2() : void
      {
         if(ItemManager.getSpecialItem(601455) == null)
         {
            this.questComplete();
            return;
         }
         var _loc1_:Rectangle = new Rectangle(0,0,68,68);
         GuideManager.instance.addTarget(_loc1_,0);
         GuideManager.instance.addGuide2Target(_loc1_,0,0,new Point(805,226),false,false,GudieDirectionType.CONTENT,false,true);
         GuideManager.instance.startGuide(0);
         PlantEventControl.addEventListener(PlantEvent.SELECT_ITEM,this.onSelectItem);
         var _loc2_:Object = new Object();
         _loc2_.isQuest = true;
         ModuleManager.toggleModule(URLUtil.getAppModule("PlantLibraryPanel"),"正在打开仓库...",_loc2_);
      }
      
      private function onSelectItem(param1:PlantEvent) : void
      {
         var event:PlantEvent = param1;
         PlantEventControl.removeEventListener(PlantEvent.SELECT_ITEM,this.onSelectItem);
         GuideManager.instance.pause();
         this._playMC = _resLib.getMovieClip("selectSeed");
         LayerManager.topLayer.addChild(this._playMC);
         PlantManager.isQuest = true;
         MovieClipUtil.playMc(this._playMC,2,this._playMC.totalFrames,function():void
         {
            PlantManager.isQuest = false;
            PlantManager.isQuest2 = true;
            DisplayUtil.removeForParent(_playMC);
            var _loc1_:Rectangle = new Rectangle(0,0,80,50);
            GuideManager.instance.addTarget(_loc1_,0);
            GuideManager.instance.addGuide2Target(_loc1_,0,0,new Point(280,338),false,false,GudieDirectionType.CONTENT);
            GuideManager.instance.startGuide(0);
            SceneManager.active.mapModel.content["land0"].addEventListener(MouseEvent.CLICK,onLand2);
         },true);
      }
      
      private function onLand2(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         SceneManager.active.mapModel.content["land0"].removeEventListener(MouseEvent.CLICK,this.onLand2);
         GuideManager.instance.pause();
         this._playMC = _resLib.getMovieClip("diandi");
         LayerManager.topLayer.addChild(this._playMC);
         MovieClipUtil.playMc(this._playMC,2,this._playMC.totalFrames,function():void
         {
            PlantManager.isQuest2 = false;
            PlantManager.isQuest = false;
            DisplayUtil.removeForParent(_playMC);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
            QuestManager.completeStep(_quest.id,2);
         },true);
      }
      
      private function next3() : void
      {
         if(ItemManager.getSpecialItem(602400) == null)
         {
            this.questComplete();
            return;
         }
         var _loc1_:Rectangle = new Rectangle(0,0,54,45);
         GuideManager.instance.addTarget(_loc1_,0);
         GuideManager.instance.addGuide2Target(_loc1_,0,0,new Point(1132,139),false,false,GudieDirectionType.CONTENT,true,false,false);
         GuideManager.instance.startGuide(0);
         PlantManager.isShow = true;
         ModuleManager.addEventListener("PlantLibraryPanel",ModuleEvent.SHOW,this.showLibrary);
      }
      
      private function questComplete() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         if(QuestManager.isAccepted(60) && QuestManager.isStepComplete(60,1) == false)
         {
            this.questCompleteNext(1);
         }
         else if(QuestManager.isAccepted(60) && QuestManager.isStepComplete(60,2) == false)
         {
            this.questCompleteNext(2);
         }
         else if(QuestManager.isAccepted(60) && QuestManager.isStepComplete(60,3) == false)
         {
            this.questCompleteNext(3);
         }
         else if(QuestManager.isAccepted(60) && QuestManager.isStepComplete(60,4) == false)
         {
            this.questCompleteNext(4);
         }
      }
      
      private function questCompleteNext(param1:int) : void
      {
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onNextStepComplete);
         QuestManager.completeStep(60,param1);
      }
      
      private function onNextStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onNextStepComplete);
         if(param1.stepId != 4)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onNextStepComplete);
            QuestManager.completeStep(60,param1.stepId + 1);
         }
         else if(param1.stepId == 3)
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,this.onComplete);
            QuestManager.completeStep(60,param1.stepId + 1);
         }
      }
      
      private function showLibrary(param1:Event) : void
      {
         GuideManager.instance.pause();
         ModuleManager.removeEventListener("PlantLibraryPanel",ModuleEvent.SHOW,this.showLibrary);
         var _loc2_:Rectangle = new Rectangle(0,0,76,26);
         GuideManager.instance.addTarget(_loc2_,0);
         GuideManager.instance.addGuide2Target(_loc2_,0,0,new Point(973,195),false,false,GudieDirectionType.CONTENT,false,true);
         GuideManager.instance.startGuide(0);
         PlantEventControl.addEventListener(PlantEvent.SELECT_TAB,this.onSelectTab);
      }
      
      private function onSelectTab(param1:PlantEvent) : void
      {
         PlantEventControl.removeEventListener(PlantEvent.SELECT_TAB,this.onSelectTab);
         GuideManager.instance.pause();
         var _loc2_:Rectangle = new Rectangle(0,0,68,68);
         GuideManager.instance.addTarget(_loc2_,0);
         GuideManager.instance.addGuide2Target(_loc2_,0,0,new Point(803,227),false,false,GudieDirectionType.CONTENT,false,true);
         GuideManager.instance.startGuide(0);
         PlantEventControl.addEventListener(PlantEvent.SELECT_ITEM,this.onSelectItem2);
      }
      
      private function onSelectItem2(param1:PlantEvent) : void
      {
         var event:PlantEvent = param1;
         PlantEventControl.removeEventListener(PlantEvent.SELECT_ITEM,this.onSelectItem2);
         GuideManager.instance.pause();
         PlantManager.isShow = false;
         this._playMC = _resLib.getMovieClip("shifei");
         LayerManager.topLayer.addChild(this._playMC);
         PlantManager.isQuest = true;
         MovieClipUtil.playMc(this._playMC,2,this._playMC.totalFrames,function():void
         {
            PlantManager.isQuest = false;
            PlantManager.isQuest2 = true;
            DisplayUtil.removeForParent(_playMC);
            var _loc1_:Rectangle = new Rectangle(0,0,80,50);
            GuideManager.instance.addTarget(_loc1_,0);
            GuideManager.instance.addGuide2Target(_loc1_,0,0,new Point(280,338),false,false,GudieDirectionType.CONTENT);
            GuideManager.instance.startGuide(0);
            SceneManager.active.mapModel.content["land0"].addEventListener(MouseEvent.CLICK,onLand3);
         },true);
      }
      
      private function onLand3(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         GuideManager.instance.pause();
         PlantManager.isQuest3 = true;
         SceneManager.active.mapModel.content["land0"].removeEventListener(MouseEvent.CLICK,this.onLand3);
         this._playMC = _resLib.getMovieClip("loading");
         LayerManager.topLayer.addChild(this._playMC);
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         QuestManager.completeStep(_quest.id,3);
         MovieClipUtil.playMc(this._playMC,2,this._playMC.totalFrames,function():void
         {
            PlantManager.isQuest2 = false;
            PlantManager.isQuest = false;
            PlantManager.isQuest3 = false;
            DisplayUtil.removeForParent(_playMC);
         },true);
      }
      
      private function next4() : void
      {
         var _loc1_:Rectangle = new Rectangle(0,0,80,50);
         GuideManager.instance.addTarget(_loc1_,0);
         GuideManager.instance.addGuide2Target(_loc1_,0,0,new Point(280,338),false,false,GudieDirectionType.CONTENT);
         GuideManager.instance.startGuide(0);
         SceneManager.active.mapModel.content["land0"].addEventListener(MouseEvent.CLICK,this.onLand4);
      }
      
      private function onSeedStatusChange(param1:PlantEvent) : void
      {
         var _loc2_:Rectangle = null;
         if(int(param1.status) == 4)
         {
            PlantEventControl.removeEventListener(PlantEvent.SEED_STATUS_CHANGE,this.onSeedStatusChange);
            _loc2_ = new Rectangle(0,0,80,50);
            GuideManager.instance.addTarget(_loc2_,0);
            GuideManager.instance.addGuide2Target(_loc2_,0,0,new Point(280,338),false,false,GudieDirectionType.CONTENT);
            GuideManager.instance.startGuide(0);
            SceneManager.active.mapModel.content["land0"].addEventListener(MouseEvent.CLICK,this.onLand4);
         }
      }
      
      private function onLand4(param1:MouseEvent) : void
      {
         QuestManager.addEventListener(QuestEvent.COMPLETE,this.onComplete);
         QuestManager.completeStep(_quest.id,4);
         GuideManager.instance.pause();
         SceneManager.active.mapModel.content["land0"].removeEventListener(MouseEvent.CLICK,this.onLand4);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         var teleport:Teleport;
         var teleport2:Teleport;
         var event:QuestEvent = param1;
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         this._playMC = _resLib.getMovieClip("complete");
         LayerManager.topLayer.addChild(this._playMC);
         teleport = AnimateElementManager.getElement(1) as Teleport;
         teleport.visible = true;
         teleport2 = AnimateElementManager.getElement(2) as Teleport;
         teleport2.visible = true;
         MovieClipUtil.playMc(this._playMC,2,this._playMC.totalFrames,function():void
         {
            PlantManager.isQuest = false;
            DisplayUtil.removeForParent(_playMC);
         },true);
      }
   }
}
