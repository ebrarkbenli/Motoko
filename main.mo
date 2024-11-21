import List "mo:base/List";
import Option "mo:base/Option";
import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";

actor Superkahraman {

  public type SuperkahramanId = Nat32;
  public type superkahraman = {
    isim : Text;
    supergucler : List.List<Text>;

  };

  private stable var next : SuperkahramanId = 0;
  private stable var superkahraman : Trie.Trie<SuperkahramanId, Superkahraman> = Trie.empty();

  public func create(superkahraman : Superkahraman) : async SuperkahramanId {
    let superkahramanId = next;

    next += 1;
    superkahraman := Trie.replace(
      superkahraman,
      key(superkahramanId),
      Nat32.equal,
      ?superkahraman
    ).0;
    return superkahramanId;

  };

  public query func read(superkahramanId : SuperkahramanId) : async ?Superkahraman {
    let result = Trie.find(superkahraman, key(superkahramanId), Nat32.equal);
    return result
  };

  public func update(superkahramanId : SuperkahramanId, superkahraman : Superkahraman) : async Bool {
    let result = Trie.find(superkahraman, key(superkahramanId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      superkahraman := Trie.replace(
        superkahraman,
        key(superkahramanId),
        Nat32.equal,
        ?superkahraman
      ).0
    };
    return exists
  };
  public func delete(superkahramanId : SuperkahramanId) : async Bool {
    let result = Trie.find(superkahraman, key(superkahramanId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      superkahraman := Trie.replace(
        superkahraman,
        key(superkahramanId),
        Nat32.equal,
        ?superkahraman
      ).0
    };
    return exists
  };

  private func key(x : superkahramanId) : Trie.Key<SuperkahramanId> {
    return {hash = x; key = x}
  };

}