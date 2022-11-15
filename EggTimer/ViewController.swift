//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation //importando blblioteca de audio

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel! // vamos usar na funcao updateTimer
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12] // 5, 7, 12 minutos representados em segundos
    var timer = Timer() // coloca o cronometro dentro dentro da variavel, para poder usar o cancelamento quando clicamos no botao
    var player: AVAudioPlayer!
    var totalTime = 0
    var secondsPassed = 0
    
    // Quando clicar no botao
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate() // Cancela o timer anterior para criar um novo
        
        // Quando clicar em algum botao, armazena o valor dentro da variavel
        let hardness = sender.currentTitle! // Soft, Medium, Hard
        
        // Atribuimos o valor do eggTimes na variavel totaltime
        totalTime = eggTimes[hardness]!
        
        // segundos voltam para 0 e o texto muda de acordo com o ovo selecionado
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        //                  atualiza a cada 1 seg                    funcao chamada a cada segundo         repete a operacao a cada 1 seg
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
        
}
    
    // esta funcao sera acionada a cada 1 segundo
    @objc func updateTimer(soundName: String) { // necessario colocar o "@objc" para conseguir executar o codigo antigo #selector...
       
       // checamos se seconds é maior que o totalTime.
        if secondsPassed < totalTime {
            
            secondsPassed += 1 // e aumentamos um numero para quando a funcao for acionada outra vez, ela acrescente um numero acima
            
            //conversao de tipos / float numbers divididos
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
        } else {
            timer.invalidate() // invalidar novamente
            titleLabel.text = "DONE"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") // pesquisa o arquivo na pasta
            player = try! AVAudioPlayer(contentsOf: url!) // reproduz a variavel criada acima
            player.play() // seleciona a variavel e reproduz o som
        }
    }
}

// Comentarios adicionais

// Alteramos o style do Progress View de default para bar para utilizar o height
