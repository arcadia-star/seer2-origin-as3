package com.taomee.seer2.core.scene
{
   import com.taomee.seer2.core.map.MapModel;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import org.taomee.ds.HashMap;
   import org.taomee.utils.DisplayUtil;
   
   public class LayerManager
   {
      
      private static var _root:Sprite;
      
      private static var _stage:Stage;
      
      private static var _rootRect:Rectangle;
      
      private static var _mapLayer:Sprite;
      
      private static var _uiLayer:Sprite;
      
      private static var _dialogLayer:Sprite;
      
      private static var _moduleLayer:Sprite;
      
      private static var _topLayer:Sprite;
      
      private static var _movieContainer:Sprite;
      
      private static var _sceneEffectContainer:Sprite;
      
      private static var _sceneMovieCover:Sprite;
      
      private static var _focusLayerStack:Vector.<Sprite>;
      
      private static var _layerInteractionRecordMap:HashMap;
      
      private static var _isDirty:Boolean;
      
      private static var _setTimeout:uint;
      
      private static var _actorManagetClass:* = getDefinitionByName("com.taomee.seer2.app.actor.ActorManager");
      
      private static var _actor:*;
      
      private static var _mapModel:MapModel;
       
      
      public function LayerManager()
      {
         super();
      }
      
      public static function setup(param1:Sprite) : void
      {
         _root = param1;
         _stage = _root.stage;
         _rootRect = new Rectangle(0,0,_root.width,_root.height);
         _stage.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
         _mapLayer = new Sprite();
         closeTabNavigation(_mapLayer);
         _mapLayer.mouseEnabled = false;
         _root.addChild(_mapLayer);
         _uiLayer = new Sprite();
         closeTabNavigation(_uiLayer);
         _uiLayer.mouseEnabled = false;
         _root.addChild(_uiLayer);
         _dialogLayer = new Sprite();
         closeTabNavigation(_dialogLayer);
         _dialogLayer.mouseEnabled = false;
         _root.addChild(_dialogLayer);
         _moduleLayer = new Sprite();
         closeTabNavigation(_moduleLayer);
         _moduleLayer.mouseEnabled = false;
         _root.addChild(_moduleLayer);
         _topLayer = new Sprite();
         closeTabNavigation(_topLayer);
         _topLayer.mouseEnabled = false;
         _root.addChild(_topLayer);
         _layerInteractionRecordMap = new HashMap();
         _focusLayerStack = new Vector.<Sprite>();
         _movieContainer = new Sprite();
         _mapLayer.addChild(_movieContainer);
         _sceneMovieCover = createCoverLayer();
      }
      
      public static function get stage() : Stage
      {
         return _stage;
      }
      
      public static function get root() : Sprite
      {
         return _root;
      }
      
      public static function get rootRect() : Rectangle
      {
         return _rootRect;
      }
      
      public static function get mapLayer() : Sprite
      {
         return _mapLayer;
      }
      
      public static function get uiLayer() : Sprite
      {
         return _uiLayer;
      }
      
      public static function get dialogLayer() : Sprite
      {
         return _dialogLayer;
      }
      
      public static function get moduleLayer() : Sprite
      {
         return _moduleLayer;
      }
      
      public static function get topLayer() : Sprite
      {
         return _topLayer;
      }
      
      public static function layout() : void
      {
         _isDirty = true;
      }
      
      private static function enterFrameHandler(param1:Event) : void
      {
         if(_isDirty)
         {
            _isDirty = false;
            sceneMove();
            _setTimeout = 0;
         }
      }
      
      public static function createCoverLayer(param1:Number = 0.5) : Sprite
      {
         var _loc2_:Sprite = new Sprite();
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginFill(0,param1);
         _loc3_.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
         _loc3_.graphics.endFill();
         _loc2_.addChild(_loc3_);
         return _loc2_;
      }
      
      private static function layoutMovie() : void
      {
         if(_sceneMovieCover)
         {
            _sceneMovieCover.width = stage.stageWidth;
            _sceneMovieCover.height = stage.stageHeight;
            if(_mapModel)
            {
               _movieContainer.x = _mapModel.x;
               _movieContainer.y = _mapModel.y;
               _sceneMovieCover.x = -_mapModel.x;
               _sceneMovieCover.y = -_mapModel.y;
            }
         }
      }
      
      public static function sceneMove() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _actor = _actorManagetClass.getActor();
         if(SceneManager.active == null)
         {
            return;
         }
         _mapModel = SceneManager.active.mapModel;
         if(_mapModel)
         {
            _loc1_ = stage.stageWidth;
            _loc2_ = stage.stageHeight;
            _loc3_ = -1;
            if(_mapModel.width <= _loc1_)
            {
               _loc4_ = 0;
               _loc6_ = _mapModel.width;
            }
            else
            {
               if(_actor)
               {
                  _loc4_ = clamp(_actor.x - _loc1_ / 2,0,_mapModel.width - _loc1_);
                  if(_mapModel.far.width > 0)
                  {
                     _loc3_ = _loc4_ * (_mapModel.width - _mapModel.far.width) / (_mapModel.width - _loc1_);
                  }
               }
               else
               {
                  _loc4_ = (_mapModel.width - _loc1_) / 2;
               }
               _loc6_ = _loc1_;
            }
            if(_mapModel.height <= _loc2_)
            {
               _loc5_ = 0;
               _loc7_ = _mapModel.height;
            }
            else
            {
               if(_actor)
               {
                  _loc5_ = clamp(_actor.y - _loc2_ / 2,0,_mapModel.height - _loc2_);
               }
               else
               {
                  _loc5_ = (_mapModel.height - _loc2_) / 2;
               }
               _loc7_ = _loc2_;
            }
            if(_mapModel.x != -_loc4_ || _loc4_ == 0)
            {
               _mapLayer.x = -_loc4_;
            }
            if(_mapModel.y != -_loc5_ || _loc5_ == 0)
            {
               _mapLayer.y = -_loc5_;
            }
            if(_loc3_ >= 0)
            {
               if(_mapModel.far.x != _loc3_)
               {
                  _mapModel.far.x = _loc3_;
               }
            }
            if(_movieContainer)
            {
               if(_movieContainer.x != -_loc4_)
               {
                  _movieContainer.x = -_loc4_;
               }
               if(_movieContainer.y != -_loc5_)
               {
                  _movieContainer.y = -_loc5_;
               }
            }
         }
      }
      
      private static function clamp(param1:Number, param2:Number, param3:Number) : Number
      {
         return Math.min(Math.max(param1,param2),param3);
      }
      
      private static function closeTabNavigation(param1:Sprite) : void
      {
         param1.tabChildren = false;
         param1.tabEnabled = false;
      }
      
      private static function recordAllLayerInteraction() : void
      {
         if(_focusLayerStack.length == 0)
         {
            recordLayerInteraction(_mapLayer);
            recordLayerInteraction(_uiLayer);
            recordLayerInteraction(_dialogLayer);
            recordLayerInteraction(_moduleLayer);
            recordLayerInteraction(_topLayer);
         }
      }
      
      private static function recordLayerInteraction(param1:Sprite) : void
      {
         _layerInteractionRecordMap.add(param1,new LayerInteractionSetting(param1.mouseChildren,param1.mouseEnabled));
      }
      
      private static function resetAllLayerInteraction() : void
      {
         resetLayerInteraction(_mapLayer);
         resetLayerInteraction(_uiLayer);
         resetLayerInteraction(_dialogLayer);
         resetLayerInteraction(_moduleLayer);
         resetLayerInteraction(_topLayer);
      }
      
      private static function resetLayerInteraction(param1:Sprite) : void
      {
         var _loc2_:LayerInteractionSetting = _layerInteractionRecordMap.getValue(param1);
         if(_loc2_ != null)
         {
            param1.mouseChildren = _loc2_.mouseChildren;
            param1.mouseEnabled = _loc2_.mouseEnabled;
         }
      }
      
      private static function pushLayerToStack(param1:Sprite) : void
      {
         _focusLayerStack.push(param1);
      }
      
      private static function popLayerFromStack() : void
      {
         resetAllLayerInteraction();
         _focusLayerStack.pop();
         if(_focusLayerStack.length == 0)
         {
            return;
         }
         var _loc1_:Sprite = _focusLayerStack.pop();
         switch(_loc1_)
         {
            case _topLayer:
               focusOnTopLayer();
               break;
            case _moduleLayer:
               focusOnModuleLayer();
               break;
            case _dialogLayer:
               focusOnDialogLayer();
               break;
            case _uiLayer:
               focusOnUILayer();
         }
      }
      
      public static function focusOnUILayer() : void
      {
         recordAllLayerInteraction();
         _mapLayer.mouseChildren = false;
         _uiLayer.mouseChildren = true;
         pushLayerToStack(_uiLayer);
      }
      
      public static function focusOnDialogLayer() : void
      {
         recordAllLayerInteraction();
         _mapLayer.mouseChildren = false;
         _uiLayer.mouseChildren = false;
         _dialogLayer.mouseChildren = true;
         pushLayerToStack(_dialogLayer);
      }
      
      public static function focusOnModuleLayer() : void
      {
         recordAllLayerInteraction();
         _mapLayer.mouseChildren = false;
         _uiLayer.mouseChildren = false;
         _dialogLayer.mouseChildren = false;
         _moduleLayer.mouseChildren = true;
         pushLayerToStack(_moduleLayer);
      }
      
      public static function focusOnTopLayer() : void
      {
         recordAllLayerInteraction();
         _mapLayer.mouseChildren = false;
         _uiLayer.mouseChildren = false;
         _dialogLayer.mouseChildren = false;
         _moduleLayer.mouseChildren = false;
         _topLayer.mouseChildren = true;
         pushLayerToStack(_topLayer);
      }
      
      public static function focusOnMapLayer() : void
      {
         recordAllLayerInteraction();
         _mapLayer.mouseChildren = true;
         _uiLayer.mouseChildren = false;
         _dialogLayer.mouseChildren = false;
         _moduleLayer.mouseChildren = false;
         _topLayer.mouseChildren = false;
         pushLayerToStack(_mapLayer);
      }
      
      public static function resetOperation() : void
      {
         popLayerFromStack();
      }
      
      public static function hideMap() : void
      {
         DisplayUtil.removeForParent(_mapLayer,false);
         DisplayUtil.removeForParent(_uiLayer,false);
         DisplayUtil.removeForParent(_dialogLayer,false);
      }
      
      public static function showMap() : void
      {
         _root.addChild(_mapLayer);
         _root.addChild(_uiLayer);
         _root.addChild(_dialogLayer);
         _root.addChild(_moduleLayer);
         _root.addChild(_topLayer);
         layout();
      }
   }
}

class LayerInteractionSetting
{
    
   
   public var mouseChildren:Boolean;
   
   public var mouseEnabled:Boolean;
   
   public function LayerInteractionSetting(param1:Boolean, param2:Boolean)
   {
      super();
      this.mouseChildren = param1;
      this.mouseEnabled = param2;
   }
}
