# Setup installation for GO 
ref :  https://youtu.be/kkNXSDInUFQ

## 1. Download golang
    
    ref: https://golang.org/dl/

    current version: ``` go version go1.14.2 windows/amd64 ```
 
## 2. Check environment variable 
 
     a. PATH : go binary is in the path i.e. :
 
      ```
      C:\Go\bin
      ```

	 a. GOROOT : GO ROOT where all go lib goes i.e.
     
     ```
     C:\Go
     
     ```
     
     b. GOPATH: Where all your project code can be found i.e.:

    ```
      C:\code
    ```
 
## 3. Download  debug package dlv
   
    ref: https://github.com/derekparker/delve

	``` 
    go get github.com/go-delve/delve/cmd/dlv 
    ```

 
 ## 4. Download Visual Studio Code 
	
    ref: https://code.visualstudio.com/

    current version: 
    ``` 
    Version: 1.44.2 (user setup)
    Electron: 7.1.11
    Chrome: 78.0.3904.130
    Node.js: 12.8.1
    V8: 7.8.279.23-electron.0
    OS: Windows_NT x64 10.0.17763
    
    ```
	
    a. enable go extenstion
    b. enable debugger
## 5. Install git
  ref: https://git-scm.com/downloads
 
  current version: 
     ``` git version 2.24.1.windows.2 ```