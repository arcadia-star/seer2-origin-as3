package com.taomee.seer2.app.processor.activity.evilBodyAct
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.event.LogicEvent;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.ModelLocator;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.utils.DisplayUtil;
   
   public class EvilBodyAct
   {
      
      private static const FOR_LIST:Array = [206032];
      
      private static const FIGHT_INDEX:int = 1655;
      
      private static const MAP_ID:Vector.<int> = Vector.<int>([90,230,330,320,470,160,720]);
      
      private static var _boss:Mobile;
      
      private static var _curIndex:int;
       
      
      public function EvilBodyAct()
      {
         super();
      }
      
      public static function setup() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
         ModelLocator.getInstance().addEventListener(LogicEvent.EVIL_BODY_UPDATE,onBossUpdate);
      }
      
      private static function onBossUpdate(param1:LogicEvent) : void
      {
         onComplete();
      }
      
      private static function onComplete(param1:SceneEvent = null) : void
      {
         var evt:SceneEvent = param1;
         if(MAP_ID.indexOf(SceneManager.prevMapID) != -1)
         {
            dispose();
         }
         _curIndex = MAP_ID.indexOf(SceneManager.active.mapID);
         if(_curIndex == -1)
         {
            return;
         }
         removeNpc();
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX)
         {
            NpcDialog.show(916,"罪恶之躯",[[0,"想抓住我？！啊哈哈哈！下辈子吧！！"]],["…………"],[function():void
            {
               ModuleManager.showAppModule("EvilBodyActPanel");
            }]);
         }
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            if(param1.infoVec[0] != 0)
            {
               addNpc(916,new Point(600,400));
            }
         });
      }
      
      private static function addNpc(param1:int, param2:Point) : void
      {
         _boss = new Mobile();
         _boss.resourceUrl = URLUtil.getNpcSwf(param1);
         _boss.x = param2.x;
         _boss.y = param2.y;
         _boss.buttonMode = true;
         _boss.scaleX = -1;
         showMouseHintAtMonster(_boss);
         MobileManager.addMobile(_boss,MobileType.NPC);
         _boss.addEventListener(MouseEvent.CLICK,onBossClick);
      }
      
      private static function removeNpc() : void
      {
         if(_boss)
         {
            DisplayUtil.removeForParent(_boss);
            _boss.removeEventListener(MouseEvent.CLICK,onBossClick);
            _boss = null;
         }
      }
      
      private static function onBossClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(916,"罪恶之躯",[[0,"你瞅啥？！没见过抢劫吗？！"]],["瞅你咋地！"],[function():void
         {
            NpcDialog.show(916,"罪恶之躯",[[0,"切~本大爷今天忙得很！没工夫陪你个小弱渣玩！让开让开！"]],["站住！别想跑！"],[function():void
            {
               NpcDialog.show(916,"罪恶之躯",[[0,"既然你这么想找打~那我就陪你玩玩~我只给你一个回合的出手机会~要不要来试试？"]],["来就来！","等我准备一下！"],[function():void
               {
                  FightManager.startFightWithWild(FIGHT_INDEX);
               }]);
            }]);
         }]);
      }
      
      private static function showMouseHintAtMonster(param1:Mobile) : void
      {
         var _loc2_:MouseClickHintSprite = new MouseClickHintSprite();
         _loc2_.y = -_loc2_.height - 100;
         _loc2_.x = (param1.width - param1.width) / 2;
         param1.addChild(_loc2_);
      }
      
      private static function dispose() : void
      {
         removeNpc();
      }
   }
}
