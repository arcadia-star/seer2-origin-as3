package seer2.next.skin {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.net.MessageEvent;

import org.taomee.ds.HashMap;

/**
 * 皮肤系统，用作皮肤存储
 * 10000-20000
 */
public class SkinManager {
    private static const SKILL_MAP_ROOT:uint = 10000;
    private static const MAGIC_NUMBER_SKILL_MAP:uint = 34715;

    public static var SKIN_MAP:HashMap = new HashMap();


    public static function save():void {
        var ty:uint = SKILL_MAP_ROOT;
        var skinMap:HashMap = new HashMap();
        SKIN_MAP.forEach(function (monster:uint, skin:uint):void {
            if (monster == 0 || skin == 0 || monster == skin) {
                return;
            }
            skinMap.add(monster, skin);
        })
        var monsters:Array = skinMap.getKeys();
        var start:* = 0;
        var end:* = 12;
        while (start < monsters.length) {
            var data:LittleEndianByteArray = new LittleEndianByteArray();
            data.writeShort(MAGIC_NUMBER_SKILL_MAP);
            for (var i:* = start; i < 12; i++) {
                var monster:* = monsters[i];
                if (monster) {
                    data.writeShort(monster);
                    data.writeShort(skinMap.getValue(monster));
                } else {
                    data.writeShort(0);
                    data.writeShort(0);
                }
            }
            Connection.send(CommandSet.CLIENT_SET_BUFFER_INFO_1063, ty, data);
            start = end;
            end += 12;
        }
    }

    public static function load(cb:Function):void {
        var skillMap:HashMap = new HashMap();
        //获取数量
        var next:Function = function (ty:uint):void {
            getBuffer(ty, function (data:LittleEndianByteArray):void {
                //忽略，后续用作magic number
                data.readUnsignedShort();
                for (var j:int = 0; j < 12; j++) {
                    var monster:uint = data.readUnsignedShort();
                    var skin:uint = data.readUnsignedShort();
                    if (monster == 0 || skin == 0 || monster == skin) {
                        SKIN_MAP = skillMap;
                        cb(skillMap);
                        return;
                    }
                    skillMap.add(monster, skin);
                }
                next(ty + 1);
            });
        }
        next(SKILL_MAP_ROOT);
    }

    public static function getBuffer(ty:uint, cb:Function):void {
        var getServerBuffer:Function = function (param1:MessageEvent):void {
            var data:LittleEndianByteArray = param1.message.getRawData().clone();
            if (ty == data.readUnsignedInt()) {
                Connection.removeCommandListener(CommandSet.CLIENT_GET_BUFFER_INFO_1062, getServerBuffer);
                cb(data);
            }
        }
        Connection.addCommandListener(CommandSet.CLIENT_GET_BUFFER_INFO_1062, getServerBuffer);
        Connection.send(CommandSet.CLIENT_GET_BUFFER_INFO_1062, ty);
    }
}
}
