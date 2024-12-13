/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.cosaverde.service;

import com.cosaverde.domain.Provincia;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public interface ProvinciaService {
   

 public List<Provincia> getAllProvincias();
  
}
