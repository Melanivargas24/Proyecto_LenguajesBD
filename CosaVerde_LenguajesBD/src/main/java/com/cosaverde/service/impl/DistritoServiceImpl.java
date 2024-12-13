/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.service.impl;


import com.cosaverde.dao.DistritoDao;
import com.cosaverde.domain.Distrito;
import com.cosaverde.service.DistritoService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author sfallas
 */
@Service
public class DistritoServiceImpl implements DistritoService {

    @Autowired
    private DistritoDao distritoDao;
    @Override
    public List<Distrito> getAllDistritos() {
        return distritoDao.findAll();
    }
    
}
