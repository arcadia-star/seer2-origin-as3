package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import org.taomee.utils.Tick;
   
   public class MapProcessor_3801 extends MapProcessor
   {
       
      
      private var _currTime:uint;
      
      private var _countTxt:TextField;
      
      private var _timeTxt:TextField;
      
      private var _completeIndex:int;
      
      public function MapProcessor_3801(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this._countTxt = _map.content["countTxt"];
         this._timeTxt = _map.content["timeTxt"];
         this._completeIndex = 0;
         ActiveCountManager.requestActiveCountList([203303,203304],function(param1:Parser_1142):void
         {
            var tele:Teleport;
            var par:Parser_1142 = param1;
            if(par.infoVec[0] >= 10)
            {
               AlertManager.showAlert("在5分钟之内成功击杀10个BOSS，返回基地",function():void
               {
                  _completeIndex = 1;
                  SceneManager.changeScene(SceneType.LOBBY,70);
               });
            }
            else
            {
               _countTxt.text = par.infoVec[0] + "/10";
            }
            if(TimeManager.getPrecisionServerTime() >= par.infoVec[1] + 300)
            {
               AlertManager.showAlert("在5分钟之内没能击杀10个BOSS，返回基地",function():void
               {
                  _completeIndex = 1;
                  SceneManager.changeScene(SceneType.LOBBY,70);
               });
            }
            else
            {
               _currTime = par.infoVec[1] + 300 - TimeManager.getPrecisionServerTime();
               _timeTxt.text = uint(_currTime / 60) + "分" + _currTime % 60 + "秒";
               Tick.instance.addRender(onTick,1000);
            }
            tele = AnimateElementManager.getElement(1) as Teleport;
            tele.addEventListener(MouseEvent.CLICK,onTele,false,1);
         });
      }
      
      private function onTele(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         event.stopImmediatePropagation();
         AlertManager.showConfirm("离开副本将会重置胜利次数，确定离开副本吗",function():void
         {
            SceneManager.changeScene(SceneType.LOBBY,70);
         });
      }
      
      private function onTick(param1:uint) : void
      {
         var c:uint = param1;
         --this._currTime;
         this._timeTxt.text = uint(this._currTime / 60) + "分" + this._currTime % 60 + "秒";
         if(this._currTime <= 0)
         {
            Tick.instance.removeRender(this.onTick);
            AlertManager.showAlert("在5分钟之内没能击杀10个BOSS，返回基地",function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
            });
         }
      }
      
      override public function dispose() : void
      {
         Tick.instance.removeRender(this.onTick);
         super.dispose();
      }
   }
}
