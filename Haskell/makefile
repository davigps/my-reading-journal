BUILD_DIR=./build

build:
	ghc --make Main.hs -odir $(BUILD_DIR) -hidir $(BUILD_DIR)
	mv ./Main $(BUILD_DIR)

run: clean build
	$(BUILD_DIR)/Main

clean:
	rm -rf $(BUILD_DIR) ./Main ./dist ./dist-newstyle
