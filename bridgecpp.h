//
//  main.cpp
//  unlettered 1.0
//
//  Created by someone on 5/11/2026.
//
//template of doom and later fogetfullness
#include <iostream>
#include <vector>


    //what does this do again?
#pragma once

    class WindowBridge {
    public:
        WindowBridge();
        ~WindowBridge();
        
        void initWindow();
        void setWindowSize(int width, int height);
        void closeWindow();
        void runEventLoop(); // why do i need to remind you to run
        
        //magic pixels template of doom and later regret
        void updatePixels(const std::vector<unsigned char>& rgbaData, int width, int height);
        
    private:
        void* opaqueWindowInstance;
        void* opaqueViewInstance;
};

