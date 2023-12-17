package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.activity.jiuWeiIceProcessAct.JiuWeiIceProcessAct;
   import com.taomee.seer2.app.processor.activity.jiuweiAvtivity.JiuWeiActivity;
   import com.taomee.seer2.app.processor.activity.miKaAct.MiKaFindProcessHandle;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_640 extends MapProcessor
   {
       
      
      private var _jiuweiActivity:JiuWeiActivity;
      
      private var _jiuWeiIceProcessAct:JiuWeiIceProcessAct;
      
      private var _mikaFindHandle:MiKaFindProcessHandle;
      
      public function MapProcessor_640(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_180);
         this._jiuweiActivity = new JiuWeiActivity();
         this._jiuWeiIceProcessAct = new JiuWeiIceProcessAct();
         this._mikaFindHandle = new MiKaFindProcessHandle(_map);
      }
      
      override public function dispose() : void
      {
         this._jiuweiActivity.dispose();
         this._jiuweiActivity = null;
         this._jiuWeiIceProcessAct.dispose();
         this._jiuWeiIceProcessAct = null;
         if(this._mikaFindHandle)
         {
            this._mikaFindHandle.dispose();
            this._mikaFindHandle = null;
         }
         super.dispose();
      }
   }
}
