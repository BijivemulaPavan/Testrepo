import * as vscode from 'vscode';

export function activate(context: vscode.ExtensionContext) {
  // Register the COBOL Tree View
  const cobolProvider = new COBOLTreeDataProvider();
  vscode.window.createTreeView('cobolExplorer', { treeDataProvider: cobolProvider });

  // Register commands
  vscode.commands.registerCommand('cobolExplorer.openFile', (resource) => {
    vscode.window.showTextDocument(resource);
  });

  vscode.commands.registerCommand('cobolExplorer.addFolder', async () => {
    const folderName = await vscode.window.showInputBox({ prompt: 'Enter folder name' });
    if (folderName) {
      cobolProvider.addFolder(folderName);
    }
  });

  vscode.commands.registerCommand('cobolExplorer.addFile', async () => {
    const fileName = await vscode.window.showInputBox({ prompt: 'Enter file name' });
    if (fileName) {
      cobolProvider.addFile(fileName);
    }
  });

  vscode.commands.registerCommand('cobolExplorer.refresh', () => {
    cobolProvider.refresh();
  });

  vscode.commands.registerCommand('cobolExplorer.mergeFolders', async () => {
    const sourceFolder = await vscode.window.showInputBox({ prompt: 'Enter source folder name' });
    const destinationFolder = await vscode.window.showInputBox({ prompt: 'Enter destination folder name' });
    if (sourceFolder && destinationFolder) {
      cobolProvider.mergeFolders(sourceFolder, destinationFolder);
    }
  });

  // Register command to show the webview
  const webviewCommand = vscode.commands.registerCommand('cobolExplorer.showWebview', () => {
    const panel = vscode.window.createWebviewPanel(
      'cobolExplorer',
      'COBOL Explorer',
      vscode.ViewColumn.One,
      { enableScripts: true }
    );

    panel.webview.html = getWebviewContent(panel, context);
  });

  // Push commands to the context subscriptions
  context.subscriptions.push(webviewCommand);
}

class COBOLTreeDataProvider implements vscode.TreeDataProvider<vscode.TreeItem> {
  private folders: Map<string, COBOLFolder> = new Map();
  private files: Map<string, COBOLFile> = new Map();


  getTreeItem(element: vscode.TreeItem): vscode.TreeItem {
    return element;
  }

  getChildren(element?: vscode.TreeItem): Thenable<vscode.TreeItem[]> {
    if (!element) {
      // Provide the top-level items
      return Promise.resolve(Array.from(this.folders.values()));
    } else if (element instanceof COBOLFolder) {
      // Provide children of a folder
      return Promise.resolve(
        element.children.map(child => this.files.get(child) || new COBOLFile(child))
      );
    } else {
      // No children for files
      return Promise.resolve([]);
    }
  }

  addFolder(folderName: string) {
    const newFolder = new COBOLFolder(folderName, []);
    this.folders.set(folderName, newFolder);
    this.refresh();
  }

  addFile(fileName: string) {
    const newFile = new COBOLFile(fileName);
    this.files.set(fileName, newFile);
    this.refresh();
  }

  mergeFolders(sourceFolderName: string, destinationFolderName: string) {
    const sourceFolder = this.folders.get(sourceFolderName);
    const destinationFolder = this.folders.get(destinationFolderName);

    if (sourceFolder && destinationFolder) {
      // Move all files from source to destination
      sourceFolder.children.forEach(file => {
        this.files.get(file)?.updatePath(destinationFolderName);
        destinationFolder.children.push(file);
        this.files.delete(file);
      });
      this.folders.delete(sourceFolderName);
      this.refresh();
    }
  }

  refresh() {
    this._onDidChangeTreeData.fire();
  }

  private _onDidChangeTreeData: vscode.EventEmitter<void> = new vscode.EventEmitter<void>();
  readonly onDidChangeTreeData: vscode.Event<void> = this._onDidChangeTreeData.event;
}

class COBOLFolder extends vscode.TreeItem {
  constructor(public readonly folderName: string, public children: string[]) {
    super(folderName, vscode.TreeItemCollapsibleState.Collapsed);
  }
}

class COBOLFile extends vscode.TreeItem {
  constructor(public readonly filePath: string) {
    super(filePath, vscode.TreeItemCollapsibleState.None);
    this.command = {
      command: 'cobolExplorer.openFile',
      title: 'Open COBOL File',
      arguments: [vscode.Uri.file(filePath)],
    };
  }

  updatePath(newParentFolder: string) {
    // Implement logic to update the file path based on the new parent folder
    // For simplicity, assuming that we do not need to actually update the filePath here
  }
}

// Function to get the content for the webview
function getWebviewContent(panel: vscode.WebviewPanel, context: vscode.ExtensionContext): string {
  const scriptUri = panel.webview.asWebviewUri(
    vscode.Uri.file(context.extensionPath + '/out/webview/main.js')
  );

  return `
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>COBOL Explorer</title>
    </head>
    <body>
      <div id="root"></div>
      <script src="${scriptUri}"></script>
    </body>
    </html>
  `;
}






















// import { commands, ExtensionContext } from "vscode";
// import { HelloWorldPanel } from "./panels/HelloWorldPanel";
// import * as vscode from 'vscode';
// import { DepNodeProvider, Dependency } from "./panels/nodeDependencies";

// export function activate(context: ExtensionContext) {
//   // Create the show hello world command
//   const showHelloWorldCommand = commands.registerCommand("hello-world.showHelloWorld", () => {
//     HelloWorldPanel.render(context.extensionUri);
//   });

//   // Add command to the extension context
//   context.subscriptions.push(showHelloWorldCommand);

//   const rootPath = (vscode.workspace.workspaceFolders && (vscode.workspace.workspaceFolders.length > 0))
// 		? vscode.workspace.workspaceFolders[0].uri.fsPath : undefined;

// 	// Samples of `window.registerTreeDataProvider`
// 	const nodeDependenciesProvider = new DepNodeProvider(rootPath);
// 	vscode.window.registerTreeDataProvider('nodeDependencies', nodeDependenciesProvider);
// 	vscode.commands.registerCommand('nodeDependencies.refreshEntry', () => nodeDependenciesProvider.refresh());
// 	vscode.commands.registerCommand('extension.openPackageOnNpm', moduleName => vscode.commands.executeCommand('vscode.open', vscode.Uri.parse(`https://www.npmjs.com/package/${moduleName}`)));
// 	vscode.commands.registerCommand('nodeDependencies.addEntry', () => vscode.window.showInformationMessage(`Successfully called add entry.`));
// 	vscode.commands.registerCommand('nodeDependencies.editEntry', (node: Dependency) => vscode.window.showInformationMessage(`Successfully called edit entry on ${node.label}.`));
// 	vscode.commands.registerCommand('nodeDependencies.deleteEntry', (node: Dependency) => vscode.window.showInformationMessage(`Successfully called delete entry on ${node.label}.`));

// }
