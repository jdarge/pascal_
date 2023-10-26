program BinaryTree;

type
  TreeNodePtr = ^TreeNode;
  TreeNode = record
    Data: Integer;
    Left: TreeNodePtr;
    Right: TreeNodePtr;
  end;

function CreateNode(Data: Integer): TreeNodePtr;
var
  NewNode: TreeNodePtr;
begin
  New(NewNode);
  NewNode^.Data := Data;
  NewNode^.Left := nil;
  NewNode^.Right := nil;
  CreateNode := NewNode;
end;

function InsertNode(var Root: TreeNodePtr; Data: Integer): TreeNodePtr;
begin
  if Root = nil then
    Root := CreateNode(Data)
  else if Data < Root^.Data then
    Root^.Left := InsertNode(Root^.Left, Data)
  else
    Root^.Right := InsertNode(Root^.Right, Data);

  InsertNode := Root;
end;

procedure InOrderTraversal(Root: TreeNodePtr);
begin
  if Root <> nil then
  begin
    InOrderTraversal(Root^.Left);
    Write(Root^.Data, ' ');
    InOrderTraversal(Root^.Right);
  end;
end;

var
  Root: TreeNodePtr;
begin
  Root := nil;

  Root := InsertNode(Root, 5);
  Root := InsertNode(Root, 3);
  Root := InsertNode(Root, 7);
  Root := InsertNode(Root, 2);
  Root := InsertNode(Root, 4);

  Write('In-Order Traversal: ');
  InOrderTraversal(Root);
end.
