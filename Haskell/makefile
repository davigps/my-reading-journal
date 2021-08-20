BUILD_DIR=./build

build:
	ghc --make Main.hs -odir $(BUILD_DIR) -hidir $(BUILD_DIR)
	mv ./Main $(BUILD_DIR)

run: build
	$(BUILD_DIR)/Main

clean:
	rm -rf $(BUILD_DIR) ./Main
