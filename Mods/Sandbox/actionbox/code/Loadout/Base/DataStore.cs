using actionbox.Entities.Weapons;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace actionbox.Loadout
{
    public static class PerkDataStore
    {
        private static Dictionary<Type, LoadoutItemData> _mapping = new Dictionary<Type, LoadoutItemData>();

        public static IReadOnlyDictionary<Type, LoadoutItemData> Data { get => _mapping; }

        public static IEnumerable<LoadoutItemData> GetAll() => Data.Values;

        public static void Register<T>(LoadoutItemData data) where T : ILoadoutPerk
        {
            _mapping.Add(typeof(T), data);
        }

        public static LoadoutItemData GetDataOf<T>() where T : ILoadoutPerk
        {
            return GetDataOf(typeof(T));
        }

        public static LoadoutItemData GetDataOf(Type type)
        {
            if (Data.ContainsKey(type))
            {
                return Data[ type ];
            }
            else
            {
                throw new InvalidOperationException();
            }
        }
    }

    public static class WeaponDataStore
    {
        private static Dictionary<Type, LoadoutItemData> _mapping = new Dictionary<Type, LoadoutItemData>();

        public static IReadOnlyDictionary<Type, LoadoutItemData> Data { get => _mapping; }

        public static IEnumerable<LoadoutItemData> GetAll() => Data.Values;

        public static void Register<T>(LoadoutItemData data) where T : ILoadoutWeapon
        {
            _mapping.Add(typeof(T), data);
        }

        public static LoadoutItemData GetDataOf<T>() where T : ILoadoutWeapon
        {
            return GetDataOf(typeof(T));
        }

        public static LoadoutItemData GetDataOf(Type type)
        {
            if (Data.ContainsKey(type))
            {
                return Data[ type ];
            }
            else
            {
                throw new InvalidOperationException();
            }
        }
    }
}
